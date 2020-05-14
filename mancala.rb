require_relative 'board'
require_relative 'player'

class Mancala
  def initialize(player1, player2)
    @board = Board.new(player1, player2)
    @player1 = Player.new(player1, 1)
    @player2 = Player.new(player2, 2)
  end
end