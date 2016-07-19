load 'pieces/piece.rb'
load 'pieces/nullpiece.rb'
load 'pieces/bishop.rb'
load 'pieces/king.rb'
load 'pieces/knight.rb'
load 'pieces/pawn.rb'
load 'pieces/queen.rb'
load 'pieces/rook.rb'
load 'errors.rb'

class Board

  attr_accessor :grid, :display

  def create_grid
    @null_piece = NullPiece.instance
    grid = Array.new(8) { Array.new(8) }

    first_row = grid.first
    second_row = grid[1]
    seventh_row = grid[6]
    eighth_row = grid[7]

    (0..7).each do |idx|
      second_row[idx] = Pawn.new(:black,self,[1,idx])
      seventh_row[idx] = Pawn.new(:white,self,[6,idx])
      (2..5).each do |idx2|
        grid[idx2][idx] = @null_piece
      end
    end

    grid[0] = populate_row(0, :black)
    grid[7] = populate_row(7, :white)

    grid

  end

  def populate_row(x, color)
    row = []

    row[0] = Rook.new(color,self,[x,0])
    row[1] = Knight.new(color,self,[x,1])
    row[2] = Bishop.new(color,self,[x,2])
    row[3] = Queen.new(color,self,[x,3])
    row[4] = King.new(color,self,[x,4])
    row[6] = Knight.new(color,self,[x,6])
    row[5] = Bishop.new(color,self,[x,5])
    row[7] = Rook.new(color,self,[x,7])

    row
  end

  def initialize
    @grid = self.create_grid
    @display = Display.new(self)
  end


  def move(start, end_pos)
    piece = self[start]
    raise InvalidMove.new  unless piece.valid_moves.include?(end_pos)
    self[start] = @null_piece
    self[end_pos] = piece
    piece.pos = end_pos
  end

  def move!(start, end_pos)
    self[end_pos] = self[start]
    self[start] = @null_piece
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    grid[row][col] = piece
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def in_check?(color)
    flat = @grid.flatten
    index = flat.index do |piece|
      piece.is_a?(King) && piece.color == color
    end
    king_pos = [index / 8,index % 8]
    flat.each do |piece|
      next if piece.color == color
      return true if piece.moves.include?(king_pos)
    end
    false
  end

  def checkmate?(color)
    flat = @grid.flatten
    return false unless in_check?(color)
    flat.each do |piece|
      next unless piece.color == color
      return false unless piece.valid_moves.empty?
    end
    true
  end

  def deep_dup
    new_board = Board.new
    (0..7).each do |i|
      (0..7).each do |j|
        if self[[i,j]].is_a?(NullPiece)
          new_board[[i,j]] = NullPiece.instance
        else
          new_piece = self[[i,j]].dup(new_board)
          new_board[[i,j]] = new_piece
        end
      end
    end
    new_board
  end
end
