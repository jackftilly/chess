class HumanPlayer
  attr_accessor :color, :name

  def initialize(display, color, name)
    @color = color
    @display = display
    @name = name
  end

  def get_move(invalid)
    start_pos = nil
    end_pos = nil
    @display.render
    if invalid
      puts "That was an invalid input... enter another input that is valid please!"
    end
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
