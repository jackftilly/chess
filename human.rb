class HumanPlayer
  attr_accessor :color, :name

  def initialize(display, color)
    @color = color
    print "Enter player name: "
    @name = gets.chomp
    @display = display
  end

  def get_move
    start_pos = nil
    end_pos = nil
    @display.render
    puts "#{@name}, please move to starting position on board and press enter"
    start_pos = nil
    until start_pos
      start_pos = @display.get_input
      @display.render
      puts "#{@name}, please move to starting position on board and press enter"
    end
    @display.render
    puts "Starting position: #{start_pos}"
    puts "#{@name}, please move to finish position on board and press enter"
    end_pos = @display.get_input
    until end_pos
      end_pos = @display.get_input
      @display.render
      puts "Starting position: #{start_pos}"
      puts "#{@name}, please move to finish position on board and press enter"
    end
    puts "You started at #{start_pos}"
    puts "You finished at #{end_pos}"
    puts "Testing if valid input now..."

    [start_pos, end_pos]
  end



end
