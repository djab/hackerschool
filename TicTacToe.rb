## djab
## HackerSchool Application: TicTacToe
## 7/29/13

class Board
  attr_reader :guide
  attr_accessor :positions
  def initialize
    @guide = %w[1 2 3 4 5 6 7 8 9]
    @positions = %w[0 0 0 0 0 0 0 0 0] # 0s are empty positions
  end
  def draw(a = %w[1 2 3 4 5 6 7 8 9])
    puts " #{a[0]} | #{a[1]} | #{a[2]} "
    puts "==========="
    puts " #{a[3]} | #{a[4]} | #{a[5]} "
    puts "==========="
    puts " #{a[6]} | #{a[7]} | #{a[8]} "
  end
end

class CoinToss
  def animate_toss # Works on Terminal.app; animation may have issues in other environments
    puts "Tossing: "
    2.times do
      print "-\r"; sleep 0.2
      print "/\r"; sleep 0.2
      print "|\r"; sleep 0.2
      print "\\\r"; sleep 0.2
    end
    print "-\r"; sleep 0.5
  end
  def toss(game)
    puts "Let's use a toin coss to see who goes first. [H]eads or [T]ails?"
    call = gets[0].upcase
    while(call != "H" && call != "T")
      puts "I'm sorry, that is not a valid answer. Please enter [H]eads or [T]ails."
      call = gets[0].upcase
    end
    toss = rand(2) # 0 = Heads, 1 = Tails
    if toss == 0
      animate_toss
      puts "Heads!"
      if call == "H"
        game.win_toss
      end
      if call == "T"
        game.lose_toss
      end
    end
    if toss == 1
      animate_toss
      puts "Tails!"
      if call == "T"
        game.win_toss
      end
      if call == "H"
        game.lose_toss
      end
    end
  end
end
class TicTacToe
  def initialize
    @board = Board.new
    puts "Welcome to TicTacToe!"
    CoinToss.new.toss(self)
  end
  def win_toss
    puts "Nice Call! You will play as 'X'."
    play_turn(1) # Human plays
  end
  def lose_toss
    puts "Tough Luck. I'll go first. I get to play as 'O'!"
    @board.positions[rand(9)] = "O"
    @board.draw(@board.positions.map{|x| x == "0" ? "\ " : x})
    play_turn(1, 1) # Human plays, second turn in game
  end
  def input_check(play)
    while not((1...10).member?(play))
      puts "You have entered an invalid input. Please  enter a digit from 1 through 9:"
      play = gets[0].to_i
    end
    play
  end
  def position_check(play, board)
    play = input_check(play)
    current = board.positions[play - 1]
    while current != "0"
      puts "That space has already been played. Please select a free position: "
      board.draw(board.positions.map{|x| x == "0" ? "\ " : x})
      play = gets[0].to_i
      play = input_check(play)
      current = board.positions[play - 1]
    end
    play
  end
  def game_over(winner = 2)
    if winner == 0 # Computer
      puts "Game Over! Unfortunately, you lost."
    elsif winner == 1 # Human
      puts "You win, congratulations!"
    elsif winner == 2 # Tie
      puts "Game Over! The game has ended in a tie."
    end
    puts "Would you like to play again? [Y]es or [N]o?"
    play_again = gets[0].upcase
    while(play_again != "Y" && play_again != "N")
      puts "I'm sorry, that is not a valid answer. Please enter [Y]es or [N]o."
      play_again = gets[0].upcase
    end
    if play_again == "Y"
      game = TicTacToe.new
    end
    if play_again == "N"
      puts "Thanks for playing. Goodbye!"
      exit
    end
  end
  def win_check(player, board)
    row1 = [board.positions[0], board.positions[1], board.positions[2]].uniq
    row2 = [board.positions[3], board.positions[4], board.positions[5]].uniq
    row3 = [board.positions[6], board.positions[7], board.positions[8]].uniq
    col1 = [board.positions[0], board.positions[3], board.positions[6]].uniq
    col2 = [board.positions[1], board.positions[4], board.positions[7]].uniq
    col3 = [board.positions[2], board.positions[5], board.positions[8]].uniq
    dyg1 = [board.positions[0], board.positions[4], board.positions[8]].uniq
    dyg2 = [board.positions[2], board.positions[4], board.positions[6]].uniq
  
    if row1.count == 1 && not(row1.include?("0")) then game_over(player)
    elsif row2.count == 1 && not(row2.include?("0")) then game_over(player)
    elsif row3.count == 1 && not(row3.include?("0")) then game_over(player)
    elsif col1.count == 1 && not(col1.include?("0")) then game_over(player)
    elsif col2.count == 1 && not(col2.include?("0")) then game_over(player)
    elsif col3.count == 1 && not(col3.include?("0")) then game_over(player)
    elsif dyg1.count == 1 && not(dyg1.include?("0")) then game_over(player)
    elsif dyg2.count == 1 && not(dyg2.include?("0")) then game_over(player)
    end
  end
  def play_turn(player, turn = 0, board = @board)
    if turn == 9 # Board is full
      game_over(2)
    end
    if player == 0 # Computer
      puts "My turn! Hmm..."; sleep 2
      available = []
      for n in 0..8
        if board.positions[n] == "0"
          available << n + 1
        end
      end
      play = available.sample # TODO: Create more intelligent AI
      board.positions[play - 1] = "O"
      board.draw(board.positions.map{|x| x == "0" ? "\ " : x})
      win_check(player, board)
      play_turn(1, turn + 1, board)
    end
    if player == 1 # Human
      puts "Your turn. Please enter a move by entering 1 through 9, based on the following map of positions:"
      @board.draw(@board.guide)
      play = gets[0].to_i
      play = position_check(play, board)
      board.positions[play - 1] = "X"
      board.draw(board.positions.map{|x| x == "0" ? "\ " : x})
      win_check(player, board)
      play_turn(0, turn + 1, board)
    end
  end
end

game = TicTacToe.new

