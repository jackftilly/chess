load 'pieces/piece.rb'
load 'pieces/nullpiece.rb'
load 'pieces/bishop.rb'
load 'pieces/king.rb'
load 'pieces/knight.rb'
load 'pieces/pawn.rb'
load 'pieces/queen.rb'
load 'pieces/rook.rb'

class Board
  attr_accessor :grid
  def create_grid
    @null_piece = NullPiece.instance
    grid = Array.new(8) { Array.new(8) }
    #0 row: black pieces
    #1 row: black pawns
    #2-5 row: nil pieces
    #6 row: white pawns
    #7 row: white pieces
    first_row = grid.first
    second_row = grid[1]
    seventh_row = grid[6]
    eighth_row = grid[7]
    (0..7).each do |idx|
      second_row[idx] = Pawn.new(:black,[1,idx])
      seventh_row[idx] = Pawn.new(:white,[6,idx])
      (2..5).each do |idx2|
        grid[idx2][idx] = @null_piece
      end
    end
    grid[0][0],grid[0][7] = Rook.new(:black,self,[0,0]), Rook.new(:black,self,[0,7])
    grid[7][0],grid[7][7] = Rook.new(:white,self,[7,0]), Rook.new(:white,self,[7,7])
    grid[0][1],grid[0][6] = Knight.new(:black,self,[0,1]), Knight.new(:black,self,[0,6])
    grid[7][1],grid[7][6] = Knight.new(:white,self,[7,1]), Knight.new(:white,self,[7,6])
    grid[0][2],grid[0][5] = Bishop.new(:black,self,[0,2]), Bishop.new(:black,self,[0,5])
    grid[7][2],grid[7][5] = Bishop.new(:white,self,[7,2]), Bishop.new(:white,self,[7,5])
    grid[0][3] = Queen.new(:black,self)
    grid[0][4] = King.new(:black,self)
    grid[7][3] = Queen.new(:white,self)
    grid[7][4] = King.new(:white,self)

    grid


  end

  def initialize
    @grid = self.create_grid
  end


  def move(start, end_pos)
    piece = self[start]
    raise "invalid move" unless piece.valid_moves.include?(end_pos)
    self[start] = @null_piece
    self[end_pos] = piece
    #todo update piece pos
    piece.pos = end_pos
  end
  def move!(start, end_pos)
    piece = self[start]
    self[start] = @null_piece
    self[end_pos] = piece
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

  def rows
    @grid
  end

  def in_check?(color)
    flat = @grid.flatten
    index = flat.find_index do |piece|
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
end
