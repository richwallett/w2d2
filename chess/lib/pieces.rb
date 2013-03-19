white = {
  white[:king] = "\u2654"
  white[:queen] = "\u2655"
  white[:rook] = "\u2656"
  white[:bishop] = "\u2657"
  white[:knight] = "\u2658"
  white[:pawn] = "\u2659"
}

black = {
  black[:king] = "\u265A"
  black[:queen] = "\u265B"
  black[:rook] = "\u265C"
  black[:bishop] = "\u265D"
  black[:knight] = "\u265E"
  black[:pawn] = "\u265F"
}

pieces = {}
pieces[:white] = white
pieces[:black] = black

class Piece
  def initialize(color, position)
    @color = color
    @position = position
  end

  def valid_move?

  end

  def possible_moves(deltas)
    deltas.each do |delta|
      move = [delta, @position].transpose.map {|x| x.reduce(:+)}
      moves << move if valid_move(move)
    end
  end

end

class Pawn < Piece
  def initialize(color, position)
    super(color, position)
  end
end

class Rook < Piece
  def initialize(color, position)
    super(color, position)
  end

  def possible_moves
    deltas = [[-2,-1], [-2,1], [2,-1], [2,1], [-1,2], [-1,-2], [1,2], [1,-2]]
    super(deltas)
  end
end

class Knight < Piece
  def initialize(color, position)
    super(color, position)
  end

  def possible_moves
    deltas = [[-2,-1], [-2,1], [2,-1], [2,1], [-1,2], [-1,-2], [1,2], [1,-2]]
    super(deltas)
  end
end

class Bishop < Piece
  def initialize(color, position)
    super(color, position)
  end
end

class Queen < Piece
  def initialize(color, position)
    super(color, position)
  end
end

class King < Piece
  def initialize(color, position)
    super(color, position)
  end
end

Rook.new(:black)
