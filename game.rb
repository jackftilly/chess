load 'board.rb'
load 'display.rb'
load 'human.rb'
load 'computer.rb'
class Game
  attr_accessor :board, :display, :player1, :player2

  def initialize
    @board = Board.new
    @display = Display.new(board)
    self.player_names
    @current_player = @player1
  end

  def player_names
    print "Enter player 1 name: "
    name = gets.chomp
    if name == "computer"
      @player1 = ComputerPlayer.new(board, :white, "MAC")
    else
      @player1 = HumanPlayer.new(display, :white, name)
    end
    print "Enter player 2 name: "
    name = gets.chomp
    if name == "computer"
      @player2 = ComputerPlayer.new(board, :black, "MAC")
    else
      @player2 = HumanPlayer.new(display, :black, name)
    end
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
    retries = 0
    begin
      start, finish = get_input(invalid)
      @board.move(start, finish)
    rescue
      p "This was not a valid move #{current_player}"
      p "move you tried to use: #{start}, #{finish}"
      invalid = true
      retries += 1
     retry if retries < 10
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

game = Game.new
game.play
