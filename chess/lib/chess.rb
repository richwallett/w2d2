require 'colorize'
load 'pieces.rb'
require 'debugger'
load 'board.rb'


class Chess
  attr_accessor :board
  def self.new_game
    player1 = HumanPlayer.new(:white)
    player2 = HumanPlayer.new(:black)
    game = Chess.new
    game.play(player1, player2)
  end

  def initialize
    @board = Board.new
  end

  def play(player1, player2)
    current_player, next_player = player1, player2
    until game_over?
      @board.display
      puts "Checkmate!  #{next_player.color} wins!" if @board.checkmate?(current_player.color)
      move = current_player.move(@board)
      unless @board.check?(move, current_player.color)
        @board.make_move(move, current_player.color)
      end

      #check if next_player in check & if in checkmate, then end game.
      current_player, next_player = next_player, current_player
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
      puts "#{@color.capitalize} Player's turn:"
      move_string = ask_for_move
      move = parse_move(move_string)
      in_check = board.check?(move, @color)
      return move if board.valid_move?(move,@color) && !in_check
      puts "Please enter a valid move, #{@color.capitalize} Player."
      puts "(You are in check.)" if in_check
    end
  end

  private

  def ask_for_move
    print "Enter move (e.g. 'b1 c3'): "
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

Chess.new_game
