class Board

  attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1, @player2 = player1, player2

    @cups = Array.new(14) { Array.new }

    place_stones
  end

  def place_stones
    # start the game with cups filled with 4 stones each
    cups.each_index do |i|
      next if i == 6 || i == 13
      cups[i] += [:stone, :stone, :stone, :stone]
    end
  end

  def make_move(start_pos, current_player_name)
    # grab the stones from the start_pos
    stones = cups[start_pos]

    # empty the cup
    cups[start_pos] = []

    # distribute the stones from the starting pos until no more stones
    cup_idx = start_pos
    until stones.empty?
      cup_idx += 1
      # overlap the board
      cup_idx = 0 if cup_idx > 13

      # player 1 places a stone in their score cup
      if cup_idx == 6 && current_player_name == player1
        cups[6] << stones.pop 
      # player 2 places a stone in their score cup
      elsif cup_idx == 13 && current_player_name == player2
        cups[13] << stones.pop
      else
        cups[cup_idx] << stones.pop
      end
    end
    
    #display the board after placing the stones
    render
    next_turn(cup_idx)
  end

  def next_turn(ending_cup_idx)
    # player goes again if cup has more stones or if pos ends in their score cup
    return :prompt if ending_cup_idx == 6 || 
                      ending_cup_idx == 13

    # switch turns if cup was empty
    return :switch if cups[ending_cup_idx].length == 1

    ending_cup_idx
  end

  private

  attr_accessor :cups
end