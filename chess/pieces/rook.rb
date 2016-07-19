require_relative 'piece'
require_relative 'sliding'
class Rook < Piece
  include SlidingPieces
  def initialize(color,board,pos = nil)
    super
    @cardinal = true
    @diagonal = false
  end

  def to_s
    return "  R  "
  end
end
