require 'byebug'
class ComputerPlayer
  attr_accessor :color
  def initialize(board, color, name)
    @board = board
    @color = color
    @name = name
    @pieces = self.pieces
  end
  def instance
    @pieces
  end

  def pieces
    pieces = []
    flat = @board.grid.flatten
    pieces_index = []
    flat.each_with_index do |el, idx|
      if el.color == color
        pieces_index << idx
      end
    end
    pieces_index.each do |idx|
      pieces << @board[[idx / 8, idx % 8]]
    end
    pieces
  end

  def get_move(invalid)
    print "BRUH WE MADE IT"
    best = capturable
    if best[0].nil?
      piece = pieces[rand(pieces.length)]
      start = piece.pos
      finish = piece.moves[0]
    else
      start, finish = capturable
    end
    print "start, finish: #{start}, #{finish}"
    [start, finish]
  end

  def capturable
    capture_pieces = []
    pieces.each do |pi|
      pi.moves.each do |move|
        if @board[move].is_a?(Piece) && @board[move].color != @color
          capture_pieces << [pi.pos, move, @board[move].class]
        end
      end
    end
    highest_val = 0
    val = 0
    best_move = []
    capture_pieces.each do |move|
      case move[2]
      when Pawn
        val = 1
      when Knight
        val = 2
      when Bishop
        val = 3
      when Rook
        val = 4
      when Queen
        val = 5
      end
      if val > highest_val
        highest_val = val
        best_move = move
      end
    end
    [best_move[0], best_move[1]]
  end


end
