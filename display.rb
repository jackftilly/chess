require 'colorize'
require_relative 'cursorable'
load 'board.rb'
class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :magenta
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :blue
    end
    if @board[[i, j]].color == :white
      text = :white
    else
      text = :black
    end
    { background: bg, color: text }
  end

  def render
    system("clear")
    puts "Fill the grid!"
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
    return nil
  end

  def play
    while true
      render
      get_input
    end
  end
end
