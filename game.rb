load 'board.rb'
load 'display.rb'
load 'human.rb'
class Game
  attr_accessor :board, :current_player, :display

  def initialize
    @board = Board.new
    @display = Display.new(board)
    @player1 = HumanPlayer.new(display, :white)
    @player2 = HumanPlayer.new(display, :black)
    @current_player = @player1
  end

  def play
    until @board.checkmate?(@current_player.color)
      play_turn
    end
    switch_player!
    puts "That is checkmate!!!! Congradulations #{current_player.name}!!!! Thank you for playing"
  end

  def play_turn
    start, finish = get_input
    @board.move(start, finish)
    @display.render
    switch_player!
    nil
  end
  def get_input
    start, finish = current_player.get_move
    until @board[start].color == @current_player.color
      start, finish = current_player.get_move
    end
    [start, finish]
  end

  def switch_player!
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end
end
