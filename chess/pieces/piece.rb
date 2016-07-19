class Piece
  attr_accessor :color, :pos, :board
  def initialize(color,board,pos = nil)
    @color = color
    @pos = pos
    @board = board
  end

  def valid_moves
    possible = []
    moves.each do |move|
      possible << move unless move_into_check?(move)
    end
    possible
  end

  def move_into_check?(move)
    new_board = deep_dup
    new_board.move!(pos, move)
    new_board.in_check?(color)
  end

  def to_s
    return color.to_s
  end

  def deep_dup
    new_board = Array.new(8) { Array.new(8) }
    (0..7).each do |i|
      (0..7).each do |j|
        new_piece = @board[i,j].dup
        new_piece.board = new_board
        new_board[i][j] = new_piece
      end
    end
    new_board
  end

end
