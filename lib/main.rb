# frozen_string_literal: true

# Save state and controls for the board
class GameState
  attr_reader :board

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
    if space >= 0 and space <= 8
      @board[space] = sign
    end
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
