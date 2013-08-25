require './player'
require './ComputerPlayer'
require './HumanPlayer'

class Hangman

  attr_accessor :dictionary, :guess_player, :answer_player, :board, :not_guessed

  def initialize
    self.dictionary = File.read('dictionary.txt').split(' ')
    self.guess_player = nil
    self.answer_player = nil
    self.board = []
    self.not_guessed = ("a".."z").to_a
  end

  # Instantiates ComputerPlayer as guessing player, HumanPlayer as answering player

  def create_comp_game
    self.guess_player = ComputerPlayer.new(@dictionary, self)
    self.answer_player = HumanPlayer.new(self)
    set_opponents(guess_player, answer_player)
  end

  # Instantiates HumanPlayer as guessing player, ComputerPlayer as answering player

  def create_human_game
    self.guess_player = HumanPlayer.new(self)
    self.answer_player = ComputerPlayer.new(@dictionary, self)
    set_opponents(guess_player, answer_player)
  end

  # Introduces opponents to one another

  def set_opponents(player1, player2)
    player1.set_opponent(player2)
    player2.set_opponent(player1)
  end

  #UI for selecting which type of game to play.  Should be called on initialization

  def choose_game
    puts "Please choose who will guess (Computer or Human):"
    guessing_player = gets.chomp

    if /comp|computer/i.match(guessing_player)
      create_comp_game

    elsif /human|h|me/i.match(guessing_player)
      create_human_game

    else
      puts "Invalid input.  Please enter either 'Human' or 'Computer'."
      choose_game
    end
    play_game
  end

  def generate_board(length)
    length.times { @board << '_' }
  end

  def update_board(guess)
    # Requests index values from answering player.
    # Sets values of indices to guess value
    if guess != nil
      indices = @answer_player.validate_guess(guess)
      indices.each do |index|
        @board[index] = guess
      end
      puts
    else
      puts "The word does not contain your guess.  Please try again."
    end

    print @board.join(' ')
  end

  def play_game
    generate_board(@answer_player.generate_target)
    @guess_player.notify_opponent_of_target(@board.size)

    while @board.include? ('_')
      puts
      guess = @guess_player.make_guess(@not_guessed).downcase
      update_board(guess)
      not_guessed.delete(guess)
    end

    puts "The guessing player has solved the word."

  end

end

if __FILE__ == $0
  hangman = Hangman.new
  hangman.choose_game


end