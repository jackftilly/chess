module SlidingPieces

  def moves
    cardinal_dirs + diagonal_dirs
  end

  def cardinal_dirs
    return [] unless @cardinal
    possible_moves = []
    deltas = [[0, 1], [0, -1], [-1, 0], [1, 0]]
    deltas.each do |delta|
      possible_moves += grow_unblocked_moves(delta)
    end

    possible_moves
  end

  def diagonal_dirs
    return [] unless @diagonal
    possible_moves = []
    deltas = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    deltas.each do |delta|
      possible_moves += grow_unblocked_moves(delta)
    end

    possible_moves
  end

  def grow_unblocked_moves(delta)
    possible = []
    dx, dy = delta
    row, col = @pos
    current_mult = 1
    current_pos = [row + dx, col + dy]
    while in_bounds?(current_pos)
      break unless @board[current_pos].color.nil?
      possible << current_pos
      current_mult += 1
      current_pos = [row + dx * current_mult, col + dy * current_mult]
    end
    possible
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

end
