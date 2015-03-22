# draw the board
# 
# loop do
#   ask the user to select an empty space on the board
#   fill in the respective space on the board with an "X"
#   break if anyone has won or if there are any spaces left on the board
#   computer selects and fills in a random empty space on the board with an "O"
#   break if anyone has won or if there are any spaces left on the board
# end
# 
# if someone has won or lost, alert them. 
# if there was a tie, let them know. 

require 'pry'

WINNING_COMBINATIONS = [[1, 2, 3], [1, 5, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [3, 5, 7], [7, 8, 9], [4, 5, 6]]

def initialize_board
  b = {}
  (1..9).each {|position| b[position] = " "}
  b
end

def draw_board(b)
  system "clear"
  puts "#{b[1]}|#{b[2]}|#{b[3]}"
  puts "-----"
  puts "#{b[4]}|#{b[5]}|#{b[6]}"
  puts "-----"
  puts "#{b[7]}|#{b[8]}|#{b[9]}"
end

def empty_positions(b)
  b.select {|k,v| v == " " }.keys
end

def user_picks_square(b)
  begin
    puts "Select an empty space on the board by entering a number from 1-9."
    user_selection = gets.chomp.to_i
  end until b[user_selection] == ' '
  b[user_selection] = 'X'
end

def computer_picks_square(b)
  if two_in_a_row?(b)
    b[two_in_a_row?(b)] = 'O'
  else
    computer_selection = empty_positions(b).sample
    b[computer_selection] = 'O'
  end
end

def two_in_a_row?(b)
  WINNING_COMBINATIONS.each do |line|
    # This only works once
    if b.values_at(*line).count('X') == 2 # && (b.values_at(*line).count(' ') == 1) This doesn't work at all
      line.each do |position| 
        return position if b[position] != 'X' 
      end
    else
      next
    end
  end
end

def check_for_winner(b)
  #currently_filled_spaces = empty_positions(b).sort # So this is empty_positions, but ordered
  WINNING_COMBINATIONS.each do |line|
    return "You" if b.values_at(*line).count('X') == 3
    return "Computer" if b.values_at(*line).count('O') == 3
  end
  nil
end

board = initialize_board # So I guess this actually creates the board, using the instructions from the method
                         # initialize_board? 
draw_board(board)

winner = nil

loop do
  user_picks_square(board)
  draw_board(board)
  computer_picks_square(board)
  binding.pry
  draw_board(board)
  winner = check_for_winner(board)
  break if winner || empty_positions(board).empty?
end

if winner == "You"
  puts "You win! Yay!"
elsif winner == "Computer"
  puts "Computer wins :( Sorry.."
elsif empty_positions(board).empty?
  puts "It's a tie!"
end