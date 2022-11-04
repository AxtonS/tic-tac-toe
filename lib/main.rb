# frozen_string_literal: true

# Save state and controls for the board
class GameState
  attr_accessor :board

  def initialize
    @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  def display
    puts "\n #{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts '-----------'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts '-----------'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]}"
  end

  def place_sign(space, sign)
    @board[space] = sign
  end

  def victory_condition(sign)
    conditions = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    i = 0
    while i < conditions.length
      if @board[conditions[i][0]] == sign && @board[conditions[i][1]] == sign && @board[conditions[i][2]] == sign
        return true
      else
        i += 1
      end
    end
  end
end

# Controls and options for the players
class Player
  attr_reader :sign, :selection
  attr_accessor :name

  def initialize(name, sign)
    @name = name
    @sign = sign
  end

  def input
    key = gets.chomp.downcase
    until %w[q w e a s d z x c tl tm tr ml mm mr bl bm br].include?(key)
      puts 'Please enter a valid input:'
      key = gets.chomp.downcase
    end
    keys = %w[q w e a s d z x c]
    semantic_keys = %w[tl tm tr ml mm mr bl bm br]
    keys.each_with_index do |k, i|
      @selection = i if key == k
    end
    semantic_keys.each_with_index do |k, i|
      @selection = i if key == k
    end
  end
end

# game = GameState.new
# puts 'Please enter the name of first player for sign X, X also goes first:'
# player1 = Player.new(gets.chomp, 'X')
# puts "\nPlease enter the name of second player for sign O:"
# player2 = Player.new(gets.chomp, 'O')
# puts "\nThere are two ways to make selections in this game, enter the corresponding keys in either grid style and press enter."
# puts ' Q | W | E          TL | TM | TR'
# puts '-----------         ------------'
# puts ' A | S | D          ML | MM | MR'
# puts '-----------         ------------'
# puts ' Z | X | C          BL | BM | BR'
#
# current_player = player1
# until game.victory_condition('X') || game.victory_condition('O')
#   puts "\n#{current_player.name} please select a space:"
#   current_player.input
#   while game.board[current_player.selection] != ' '
#     puts "\nError, please select an empty space to place your sign:"
#     current_player.input
#   end
#   game.place_sign(current_player.selection, current_player.sign)
#   game.display
#   if game.victory_condition(current_player.sign) == true
#     puts "\nCongratulations #{current_player.name} for the victory, may god have mercy upon this wretched video game"
#     game.board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
#     current_player = player2
#     puts "\nNew Game!"
#     puts "\nPlease enter the name of first player for sign X, X also goes first:"
#     player1.name = gets.chomp
#     puts "\nPlease enter the name of second player for sign O:"
#     player2.name = gets.chomp, 'O'
#     puts "\nThere are two ways to make selections in this game, enter the corresponding keys in either grid style
#     and press enter."
#     puts ' Q | W | E          TL | TM | TR'
#     puts '-----------         ------------'
#     puts ' A | S | D          ML | MM | MR'
#     puts '-----------         ------------'
#     puts ' Z | X | C          BL | BM | BR'
#   end
#   current_player = (current_player == player1 ? player2 : player1)
# end
