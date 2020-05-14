class Board

  def initialize(player1, player2)
    @player1, @player2 = player1, player2

    @cups = Array.new(14) { Array.new }

    place_stones
  end

  def place_stones
    #start the game with cups filled with 4 stones each
    cups.each_index do |i|
      next if i == 6 || i == 13
      cups[i] += [:stone, :stone, :stone, :stone]
    end
  end

  private

  attr_accessor :cups
end