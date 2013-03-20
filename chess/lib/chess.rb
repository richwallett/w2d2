require 'colorize'
load 'pieces.rb'
require 'debugger'
load 'board.rb'


class Chess #Rev great graphics. Really enjoyed playing this

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new(:white)
    @player2 = HumanPlayer.new(:black)
  end

  def play
    until game_over?
      @board.display
      move = @player1.move(@board)
      # 3 queries piece to see if move is legal (check?)
      @board.make_move(move, @player1.color)
      # 2 updates the piece with new position
      @player1, @player2 = @player2, @player1 #switch players, repeat
    end
  end

  private
  def game_over?
    false
  end
end

class HumanPlayer
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def move(board)
    while true
      move_string = ask_for_move
      move = parse_move(move_string)
      return move if board.valid_move?(move,@color)
      puts "Please enter a valid move, #{@color.capitalize} Player."
    end
  end

  private

  def ask_for_move
    print "Enter move (e.g. 'a1 h5'): "
    gets.chomp
  end

  def parse_move(move_string)
    files = "abcdefgh" # files are columns
    ranks = "87654321" # ranks are rows
    moves = move_string.split(" ")
    moves.map { |move| [files.index(move[0]), ranks.index(move[1])] }
  end
end



class MoveNode
  #used to build move tree to caclulate check/mate
end

chess = Chess.new
chess.play
