module SteppingPieces

  def moves
    possible = []
    row, col = pos
    move_difs.each do |diff|
      new_pos = [row+diff[0],col+diff[1]]
      possible << new_pos if in_bounds?(new_pos) && @board[new_pos].color != @color
    end
    possible
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end
  
end
