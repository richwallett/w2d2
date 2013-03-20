require 'debugger'
class Board
  def initialize
    make_board
    @captured_pieces = Hash.new([])
  end

  def display
    print "   "
    ("a".."h").each {|letter| print " #{letter.colorize(:red)} "}
    puts
    @board.each_with_index do |row, rank|
      print " #{8-rank} ".colorize(:red)
      row.each_with_index do |tile, file|
        display_character = tile.nil? ? "   " : " #{tile.display_character} "
        if (rank + file).odd?
          print display_character.colorize(:background => :light_blue)
        else
          print display_character.colorize(:background => :light_white)
        end
      end
      display_captured_pieces(:black) if rank == 7 #REV: nice touch to display captured pieces
      display_captured_pieces(:white) if rank == 0
      puts
    end

  end

  def make_move(move, color)
    #move looks like this [[0,1],[7,4]]
    if valid_move?(move, color)
      piece = remove_piece(move[0])
      capture_piece(move[1])
      place_piece(piece, move[1])
    end
    piece.position = move[1]
  end

  def valid_move?(move, color)
    # checks if piece at location is the correct color
    piece = @board[move[0][1]][move[0][0]]
    return false if piece.nil? || piece.color != color
    piece.can_move_to?(self,move[1])
    # checks with piece to see if it can make the move
  end

  def piece_at(location)
    @board[location[1]][location[0]]
  end

  def move_on_board?(location)
    x,y = location
    (0..7).include?(x) && (0..7).include?(y)
  end

  private

  def remove_piece(location)
    piece = @board[location[1]][location[0]]
    @board[location[1]][location[0]] = nil
    piece
  end

  def place_piece(piece, location)
    @board[location[1]][location[0]] = piece
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
      print " #{piece.display_character} "
    end
  end

  #creating the board helper functions below
  def make_board
    make_blank_board
    populate_board
  end

  def make_blank_board
    @board = []
    8.times do
      row = []
      8.times {row << nil}
      @board << row
    end
  end

  def populate_board
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    #debugger
    @board.each_with_index do |row, rank|
      color = :black if [0,1].include?(rank)
      color = :white if [6,7].include?(rank)

      row.each_with_index do |tile, file|
        position = [file, rank]
        if [0,7].include?(rank)
          @board[rank][file] = back_row[file].new(color, position)
        elsif [1,6].include?(rank)
          @board[rank][file] = Pawn.new(color, position)
        end
      end
    end
  end

end