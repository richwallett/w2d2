
class Chess
  # has play loop
  def initialize(player1, player2)
    @board = Board.new
  end
end

class HumanPlayer
end

class Board
  def initialize
    @board = make_board
  end

  def make_board
    @board = []
    8.times do
      row = []
      8.times {row << nil}
      @board << row
    end
  end


end

class Piece
  def initialize(color)
    @color = color
  end

  def color
    @color
  end

  def king_in_check?
  end
end

class Pawn < Piece
  def initialize(color)
    super(color)
  end

  def display
    color == :white ? "\u2659" : "\u265F"
  end
end

class Rook < Piece
  def initialize(color)
    super(color)
  end

  def display
    color == :white ? "\u2656" : "\u265C"
  end
end

class Bishop < Piece
  def initialize(color)
    super(color)
  end

  def display
    color == :white ? "\u2657" : "\u265D"
  end
end

class Knight < Piece
  def initialize(color)
    super(color)
  end

  def display
    color == :white ? "\u2658" : "\u265E"
  end
end

class King < Piece
  def initialize(color)
    super(color)
  end

  def display
    color == :white ? "\u2654" : "\u265A"
  end
end

class Queen < Piece
  def initialize(color)
    super(color)
  end

  def display
    color == :white ? "\u2655" : "\u265B"
  end
end

class MoveNode
  #used to build move tree to caclulate check/mate
end
