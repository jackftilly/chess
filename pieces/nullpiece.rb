require 'singleton'
class NullPiece
  include Singleton
  attr_accessor :color, :pos
  def color
    nil
  end

  def moves
    []
  end

  def valid_moves
    []
  end

  def to_s
    "     "
  end

  def empty?
    true
  end

  def dup
    self
  end

end
