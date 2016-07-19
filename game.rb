load 'board.rb'
load 'display.rb'
load 'human.rb'
class Game
  attr_accessor :board, :display

  def initialize
    @board = Board.new
    @display = Display.new(board)
    @player1 = HumanPlayer.new(display, :white)
    @player2 = HumanPlayer.new(display, :black)
    @current_player = @player1
  end

  def play
    play_turn until @board.checkmate?(@current_player.color)

    switch_player!
    puts "That is checkmate!!!! Congratulations #{current_player.name}!!!! Thank you for playing"
  end

  
  private
  attr_accessor :current_player
  def play_turn
    invalid = false
    begin
      start, finish = get_input(invalid)
      @board.move(start, finish)
    rescue
      print "This was not a valid move"
      invalid = true
      retry
    end
    @display.render
    switch_player!
    nil
  end
  def get_input(invalid)
    start, finish = current_player.get_move(invalid)
    until @board[start].color == @current_player.color
      start, finish = current_player.get_move
    end
    [start, finish]
  end

  def switch_player!
    case @current_player
    when @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end
end
