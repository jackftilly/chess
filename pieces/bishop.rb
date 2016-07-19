require_relative 'piece'
require_relative 'sliding'
class Bishop < Piece
  include SlidingPieces

  def initialize(color,board,pos = nil)
    super
    @cardinal = false
    @diagonal = true
  end


  def to_s
    return "  B  "
  end

end
