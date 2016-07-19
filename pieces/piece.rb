class Piece
  attr_accessor :color, :pos, :board
  def initialize(color,board,pos = nil)
    @color = color
    @pos = pos
    @board = board
  end
  def pos
    @pos
  end
  def valid_moves
    possible = []
    moves.each do |move|
      possible << move unless move_into_check?(move)
    end
    possible
  end

  def move_into_check?(move)
    new_board = @board.deep_dup
    new_board.move!(pos, move)
    new_board.in_check?(color)
  end

  def to_s
    return color.to_s
  end

  def dup(new_board)
    new_piece = @board[@pos].class.new(@color, new_board, @pos)
  end


end
