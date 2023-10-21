require_relative 'main.rb'

game = GameState.new
puts 'Please enter the name of first player for sign X, X also goes first:'
player1 = Player.new(gets.chomp, 'X')
puts "\nPlease enter the name of second player for sign O:"
player2 = Player.new(gets.chomp, 'O')
puts "\nThere are two ways to make selections in this game, enter the corresponding keys in either grid style and press enter."
puts ' Q | W | E          TL | TM | TR'
puts '-----------         ------------'
puts ' A | S | D          ML | MM | MR'
puts '-----------         ------------'
puts ' Z | X | C          BL | BM | BR'

current_player = player1
until game.victory_condition('X') || game.victory_condition('O')
  puts "\n#{current_player.name} please select a space:"
  current_player.input
  while game.board[current_player.selection] != ' '
    puts "\nError, please select an empty space to place your sign:"
    current_player.input
  end
  game.place_sign(current_player.selection, current_player.sign)
  game.display
  if game.victory_condition(current_player.sign) == true
    puts "\nCongratulations #{current_player.name} for the victory, may god have mercy upon this wretched video game"
    game = GameState.new
    current_player = player2
    puts "\nNew Game!"
    puts "\nPlease enter the name of first player for sign X, X also goes first:"
    player1.name = gets.chomp
    puts "\nPlease enter the name of second player for sign O:"
    player2.name = gets.chomp
    puts "\nThere are two ways to make selections in this game, enter the corresponding keys in either grid style
    and press enter."
    puts ' Q | W | E          TL | TM | TR'
    puts '-----------         ------------'
    puts ' A | S | D          ML | MM | MR'
    puts '-----------         ------------'
    puts ' Z | X | C          BL | BM | BR'
  end
  current_player = (current_player == player1 ? player2 : player1)
end
