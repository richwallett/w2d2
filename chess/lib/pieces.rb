white = {}
  white[:king] = "\u2654"
  white[:queen] = "\u2655"
  white[:rook] = "\u2656"
  white[:bishop] = "\u2657"
  white[:knight] = "\u2658"
  white[:pawn] = "\u2659"

black = {}
  black[:king] = "\u265A"
  black[:queen] = "\u265B"
  black[:rook] = "\u265C"
  black[:bishop] = "\u265D"
  black[:knight] = "\u265E"
  black[:pawn] = "\u265F"

$pieces = {}
$pieces[:white] = white
$pieces[:black] = black


class Piece
  attr_accessor :position

  def initialize(color, position, type)
    @color = color
    @position = position
    # Not sure if best way to do this
    @display_character = $pieces[color][type]
  end

  def display_character
    @display_character
  end

  def color
    @color
  end

  def can_move_to?(board, end_location)
    poss_moves = possible_moves(board)
    debugger
    poss_moves.include?(end_location)
  end

  def possible_moves(deltas, allowed_steps, board)

    possible_moves = []
    deltas.each do |delta|
      current_position = @position
      max_number_of_moves.times do
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

  def can_move_to?(board, end_location)
    true
  end

  def possible_moves(board)

    forward_deltas = [[0,1]]
    #let them move two if they are in starting rank
    allowed_steps = [2,7].include?(position[1]) ?  2 : 1
    #swap if black
    deltas.map! { |delta| [delta[0],-delta[1]] } if @color == :black
    possible_moves = super(forward_deltas, allowed_steps, board)

    take_deltas = [[1,1], [-1,1]]


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

  def possible_moves
    deltas = [[-2,-1], [-2,1], [2,-1], [2,1], [-1,2], [-1,-2], [1,2], [1,-2]]
    super(deltas, 1, board)
  end
end

class Bishop < Piece
  def initialize(color, position)
    super(color, position, :bishop)
  end

  def possible_moves
    deltas = [[-1,-1], [-1,1], [1,-1], [1,1]]
    super(deltas, 8, board)
  end
end

class Queen < Piece
  def initialize(color, position)
    super(color, position, :queen)
  end

  def possible_moves
    deltas = [[-1,-1], [-1,1], [1,-1], [1,1], [-1,0], [0,-1], [1,0], [0,1]]
    super(deltas, 8, board)
  end
end

class King < Piece
  def initialize(color, position)
    super(color, position, :king)
  end

  def possible_moves
    deltas = [[-1,-1], [-1,1], [1,-1], [1,1], [-1,0], [0,-1], [1,0], [0,1]]
    super(deltas, 1, board)
  end
end

