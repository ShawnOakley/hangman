require './player'
require './ComputerPlayer'
require './HumanPlayer'

class Hangman

  attr_accessor :dictionary, :guess_player, :answer_player, :board

  def initialize
    self.dictionary = File.read('dictionary.txt').split(' ')
    self.guess_player = nil
    self.answer_player = nil
    self.board = []
  end

  # Instantiates ComputerPlayer as guessing player, HumanPlayer as answering player

  def create_comp_game
    self.guess_player = ComputerPlayer.new(self, @dictionary)
    self.answer_player = HumanPlayer.new(self)
    set_opponents(guess_player, answer_player)
  end

  # Instantiates HumanPlayer as guessing player, ComputerPlayer as answering player

  def create_human_game
    self.guess_player = HumanPlayer.new(self)
    self.answer_player = ComputerPlayer.new(self, @dictionary)
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

  def play_game
    target_length = @answer_player.generate_target
    target_length.times do
      @board << '_'
    end

    puts @board
  end


  end


end

if __FILE__ == $0
  hangman = Hangman.new
  hangman.choose_game

end