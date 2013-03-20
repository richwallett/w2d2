class Piece
  attr_accessor :position
  attr_reader :type, :color

  def initialize(color, position, type)
    @color = color
    @position = position
    @type = type
  end

  def dup
    return self.class.new(self.color, self.position)
  end

  def can_move_to?(board, end_location)
    possible_moves(board).include?(end_location)
  end

  def possible_moves(deltas, allowed_steps, board)
    possible_moves = []
    deltas.each do |delta|
      current_position = @position
      allowed_steps.times do
        move = [delta, current_position].transpose.map {|x| x.reduce(:+)}
        #above, takes: [[a,b],[c,d]] => [[a+c], [b+d]]
        break unless board.move_on_board?(move)
        possible_moves << move if board.piece_at(move).nil?
        if !board.piece_at(move).nil?
          possible_moves << move if board.piece_at(move).color != self.color
          break
        end
        current_position = move
      end
    end
    possible_moves
  end
end

class Pawn < Piece
  def initialize(color, position)
    super(color, position, :pawn)
  end

  def possible_moves(board)
    possible_moves = []
    forward_deltas = [[0,-1]]
    #let them move two if they are in starting rank
    allowed_steps = [1,6].include?(position[1]) ?  2 : 1
    #swap if black
    forward_deltas.map! { |delta| [delta[0],-delta[1]] } if @color == :black
    possible_forward_moves = super(forward_deltas, allowed_steps, board)
    possible_forward_moves.each do |move|
      possible_moves << move if board.piece_at(move).nil?
    end
    take_deltas = [[1,-1], [-1,-1]]
    take_deltas.map! { |delta| [delta[0],-delta[1]] } if @color == :black
    possible_take_moves = super(take_deltas, 1, board)
    possible_take_moves.each do |move|
      if !board.piece_at(move).nil? && board.piece_at(move).color != color
        possible_moves << move
      end
    end

    possible_moves
  end
end

class Rook < Piece
  def initialize(color, position)
    super(color, position, :rook)
  end

  def possible_moves(board)
    deltas = [[-1,0], [0,-1], [1,0], [0,1]]
    super(deltas, 8, board)
  end
end

class Knight < Piece
  def initialize(color, position)
    super(color, position, :knight)
  end

  def possible_moves(board)
    deltas = [[-2,-1], [-2,1], [2,-1], [2,1], [-1,2], [-1,-2], [1,2], [1,-2]]
    super(deltas, 1, board)
  end
end

class Bishop < Piece
  def initialize(color, position)
    super(color, position, :bishop)
  end

  def possible_moves(board)
    deltas = [[-1,-1], [-1,1], [1,-1], [1,1]]
    super(deltas, 8, board)
  end
end

class Queen < Piece
  def initialize(color, position)
    super(color, position, :queen)
  end

  def possible_moves(board)
    deltas = [[-1,-1], [-1,1], [1,-1], [1,1], [-1,0], [0,-1], [1,0], [0,1]]
    super(deltas, 8, board)
  end
end

class King < Piece
  def initialize(color, position)
    super(color, position, :king)
  end

  def possible_moves(board)
    deltas = [[-1,-1], [-1,1], [1,-1], [1,1], [-1,0], [0,-1], [1,0], [0,1]]
    super(deltas, 1, board)
  end
end
