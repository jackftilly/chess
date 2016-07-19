require_relative 'piece'
require_relative 'sliding'
class Queen < Piece
  include SlidingPieces
  def initialize(color,board,pos = nil)
    super
    @cardinal = true
    @diagonal = true
  end

  def to_s
    return "  Q  "
  end

end
