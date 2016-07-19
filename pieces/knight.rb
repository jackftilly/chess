require_relative 'piece'
require_relative 'stepping'
class Knight < Piece
  include SteppingPieces

  def to_s
    return "  N  "
  end

  def move_difs
    [
      [-2, -1],
      [-2,  1],
      [-1, -2],
      [-1,  2],
      [ 1, -2],
      [ 1,  2],
      [ 2, -1],
      [ 2,  1]
    ]
  end
end
