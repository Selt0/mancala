require_relative 'board'
require_relative 'player'

class Mancala

  attr_reader :player1, :player2

  def initialize(player1, player2)
    @board = Board.new(player1, player2)
    @player1 = Player.new(player1, 1)
    @player2 = Player.new(player2, 2)
  end

  def play
    puts
    puts "Welcome. Let's play Mancala"
    puts
    board.render
    current_player = player1

    until game_over?
      take_turn(current_player)
      switch_turn
    end

    puts "Game is finished! #{winner_message}"
  end

  def take_turn(current_player)
    move_result = :prompt

    until move_result == :switch
      if move_result == :prompt
        print_indices

        begin
          start_pos = current_player.prompt
          start_pos -= 1 if start_pos <= 6
          board.valid_move?(start_pos)
        rescue => exception
          puts e.message
          retry
        end

        move_result = board.make_move(start_pos, current_player.name)
      else
        move_result = board.make_move(move_result, current_player.name)
      end
      break if game_over?
    end
  end

  def game_over?
    board.one_side_empty?
  end

  def switch_turn
    current_player = current_player == player1 ? player2 : player1
  end

  def winner_message
    winner = board.winner
    if winner == :draw
      "It was a draw!"
    else
      "Congrats, #{winner}!"
    end
  end

  def print_indices
    puts "\nCup indices: "
    puts "12  11  10   9   8   7"
    puts " 1   2   3   4   5   6"
    puts
  end

  private

  attr_reader :board
end