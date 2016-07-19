require_relative 'piece'
require_relative 'stepping'
class King < Piece
  include SteppingPieces

  def to_s
    return "  K  "
  end

  def move_difs
    [
      [0, 1],
      [1, 1],
      [1, 0],
      [1, -1],
      [0, -1],
      [-1, -1],
      [-1, 0],
      [-1, 1]
    ]
  end
end
