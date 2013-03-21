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
    in_check = false
    until game_over?
      @board.display
      if @board.checkmate?(current_player.color)
        puts "Checkmate!  #{next_player.color} wins!"
        break
      end
      move = current_player.move(@board, in_check)
      unless @board.check?(move, current_player.color)
        @board.make_move(move, current_player.color)
      end
      in_check = @board.check?(move,next_player.color)
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

  def move(board, in_check)
    while true
      puts "#{@color.capitalize} Player's turn#{" (you are in check)" if in_check}."
      move_string = ask_for_move
      move = parse_move(move_string)
      in_check = board.check?(move, @color)
      return move if board.valid_move?(move,@color) && !in_check
      puts "Please enter a valid move, #{@color.capitalize} Player  (e.g. 'b1 c3')."
      puts "(You are in check.)" if in_check
    end
  end

  private

  def ask_for_move
    print "Enter move: "
    gets.chomp
  end

  def parse_move(move_string)
    files = "abcdefgh" # files are columns
    ranks = "87654321" # ranks are rows
    moves = move_string.split(" ")
    moves.map { |move| [files.index(move[0]), ranks.index(move[1])] }
  end

  def format_correct?(move_string)
    files = "abcdefgh" # files are columns
    ranks = "87654321" # ranks are rows
    return false unless move_string.length == 5 && move_string[2] == " " &&
      files.include?(move_string[0]) && files.include?(move_string[3]) &&
      ranks.include?(move_string[2]) && ranks.include?(move_string[4])
    true
  end
end



class MoveNode
  #used to build move tree to caclulate check/mate
end

Chess.new_game
