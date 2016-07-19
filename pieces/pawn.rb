require_relative 'piece'
class Pawn < Piece
  def to_s
    return "  P  "
  end

  def moves
    possible_moves = []
    if color == :black
      if pos[0] == 1
        possible_moves += move_spots(2)
      else
        possible_moves += move_spots(1)
      end
    else
      if pos[0] == 6
        possible_moves += move_spots(2)
      else
        possible_moves += move_spots(1)
      end
    end
    possible_moves += takers
    possible_moves
  end

  def move_spots(x)
    possible_moves = []
    if color == :black
      row, col = pos

      i = 1
      until i == (x + 1)
        possible_moves << [row + i, col] if @board[[row + i,col]].is_a?(NullPiece)
        i += 1
      end
    else
      row, col = pos
      i = 1
      until i == (x + 1)
        possible_moves << [row - i, col] if @board[[row - i,col]].is_a?(NullPiece)
        i += 1
      end
    end

    def takers
      take = []
      if color == :black
        row, col = pos
        if @board[[row + 1, col + 1]].is_a?(Piece)
          if @board[[row + 1, col + 1]].color == :white
            take << [row + 1, col + 1]
          end
        end
        if @board[[row + 1, col - 1]].is_a?(Piece)
          if @board[[row + 1, col - 1]].color == :white
            take << [row + 1, col - 1]
          end
        end
      else
        row, col = pos
        if @board[[row - 1, col + 1]].is_a?(Piece)
          if @board[[row - 1, col + 1]].color == :black
            take << [row - 1, col + 1]
          end
        end
        if @board[[row - 1, col - 1]].is_a?(Piece)
          if @board[[row - 1, col - 1]].color == :black
            take << [row - 1, col - 1]
          end
        end
      end
      take
    end

    possible_moves
  end
end
