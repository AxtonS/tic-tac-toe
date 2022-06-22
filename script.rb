# frozen_string_literal: true

# Save state and controls for the board
class GameState
  attr_accessor :board

  def initialize
    @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  def display
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]}"
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
      @board[conditions[i][0]] && @board[conditions[i][1]] && @board[conditions[i][2]] == sign ? true : false
      i += 1
    end
  end
end

# Controls and options for the players
class Player
  attr_reader :name, :sign, :selection

  def initialize(name, sign)
    @name = name
    @sign = sign
  end

  def input(key)
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

# testing victory_condition method that is currently broken
game = GameState.new
game.board = ['X', 'X', 'X', ' ', ' ', ' ', ' ', ' ', ' ']
game.display

puts 'correct' if game.victory_condition('X') == true
puts 'Please enter the name of first player:'
player1 = Player.new(gets.chomp, 'X')
puts 'Please enter the name of second player:'
player2 = Player.new(gets.chomp, 'O')

current_player = player1
until game.victory_condition('X') || game.victory_condition('O')
  puts "#{current_player.name} please select a space"
  current_player.input(gets.chomp)
  if game.board[current_player.selection] != ' '
    puts 'Error, please select an empty space to place your sign'
    current_player.input(gets.chomp)
  end
  game.place_sign(current_player.selection, current_player.sign)
  game.display
  if game.victory_condition(current_player.sign)
    puts "Congratulations #{current_player.name} for the victory, may god have mercy upon this video game"
  end
  current_player = (current_player == player1 ? player2 : player1)
end
