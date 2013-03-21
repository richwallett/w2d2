require 'debugger'



class Board
  attr_accessor :grid

  def initialize
    make_board
    @captured_pieces = Hash.new([])
  end


  def display
    print "   ".colorize(:background => :white)
    ("a".."h").each {|letter| print " #{letter} ".colorize(:red).colorize(:background => :white)}
    puts
    @grid.each_with_index do |row, rank|
      print " #{8-rank} ".colorize(:red).colorize(:background => :white)
      row.each_with_index do |tile, file|
        unless tile.nil?
          display_character = " #{find_display_char(tile.color, tile.type)} "
        else
          display_character = "   "
        end
        if (rank + file).odd?
          print display_character.colorize(:black).colorize(:background => :light_blue)
        else
          print display_character.colorize(:black).colorize(:background => :light_white)
        end
      end
      display_captured_pieces(:black) if rank == 7
      display_captured_pieces(:white) if rank == 0
      puts
    end
  end



  def make_move(move, color)
    if valid_move?(move, color)
      piece = remove_piece(move[0])
      capture_piece(move[1])
      place_piece(piece, move[1])
    end
    piece.position = move[1] unless piece.nil?
  end

  def valid_move?(move, color)
    piece = self[move[0]]
    return false if piece.nil? || piece.color != color
    piece.can_move_to?(self,move[1])
  end

  def piece_at(location)
    self[location]
  end

  def move_on_board?(location)
    x,y = location
    (0..7).include?(x) && (0..7).include?(y)
  end

  def check?(move, color)
    duped_board = self.dup
    duped_board.make_move(move, color)
    king_position = duped_board.find_king_position(color)
    duped_board.grid.each do |row|
      row.each do |piece|
        unless piece.nil? || piece.color == color
          return true if piece.can_move_to?(duped_board, king_position)
        end
      end
    end
    false
  end


  def checkmate?(color)
    moves = all_moves(color)
    moves.each do |move|
      return false if !check?(move, color)
    end
    true
  end


  def all_moves(color)
    all_moves = []
    @grid.each do |row|
      row.each do |piece|
        next if piece.nil? || piece.color != color
        piece.possible_moves(self).each do |end_position|
          all_moves << [piece.position, end_position]
        end
      end
    end
    all_moves
  end

  def dup
    duped_board = Board.new
    duped_board.grid = deep_dup(@grid)
    duped_board
  end

  def find_king_position(color)
    @grid.each do |row|
      row.each do |piece|
        next if piece.nil?
        return piece.position if (piece.class == King && piece.color == color)
      end
    end
  end


  private

  def [](location)
    @grid[location[1]][location[0]]
  end

  def []=(location, new_value) # self[location] = new_value
    @grid[location[1]][location[0]] = new_value
  end

  def deep_dup(board)
    new_board = []
    board.each do |el|
      if el.is_a?(Array)
        new_board << deep_dup(el)
      else
        new_board << (el.nil? ? nil : el.dup)
      end
    end
    new_board
  end

  def remove_piece(location)
    piece = self[location]
    self[location] = nil
    piece
  end

  def place_piece(piece, location)
    self[location] = piece
  end

  def capture_piece(location)
    unless piece_at(location).nil?
      piece = remove_piece(location)
      @captured_pieces[piece.color] += [piece]
    end
  end

  def display_captured_pieces(color)
    print "   "
    @captured_pieces[color].each do |piece|
      print "#{find_display_char(piece.color, piece.type)}".colorize(:black)
    end
  end

  #creating the board helper functions below
  def make_board
    make_blank_board
    populate_board
  end

  def make_blank_board
    grid = []
    8.times do
      row = []
      8.times {row << nil}
      grid << row
    end
    @grid = grid
  end

  def populate_board
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    @grid.each_with_index do |row, rank|
      color = :black if [0,1].include?(rank)
      color = :white if [6,7].include?(rank)

      row.each_with_index do |tile, file|
        position = [file, rank]
        if [0,7].include?(rank)
          @grid[rank][file] = back_row[file].new(color, position)
        elsif [1,6].include?(rank)
          @grid[rank][file] = Pawn.new(color, position)
        end
      end
    end
  end

  def find_display_char(color, piece)
    white = {
      :king => "\u2654",
      :queen => "\u2655",
      :rook => "\u2656",
      :bishop => "\u2657",
      :knight => "\u2658",
      :pawn => "\u2659",
      }

    black = {
      :king => "\u265A",
      :queen => "\u265B",
      :rook => "\u265C",
      :bishop => "\u265D",
      :knight => "\u265E",
      :pawn => "\u265F",
    }

    pieces = {
    :white => white,
    :black => black,
    }

    pieces[color][piece]
  end

end