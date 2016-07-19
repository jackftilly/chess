require 'singleton'
class NullPiece
  include Singleton

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

end
