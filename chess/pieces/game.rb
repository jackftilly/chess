class Game

  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new
    @player2 = HumanPlayer.new
  end

  def play
    until game.over?
      player.play_turn
    end
  end
end

class HumanPlayer
  def play_turn
    print "Enter move: "
    input = gets.chomp
  end
end
