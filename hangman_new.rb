require './player'
require './ComputerPlayer'
require './HumanPlayer'

class Hangman

  attr_accessor :dictionary, :guess_player, :answer_player

  def initialize
    self.dictionary = File.read('dictionary.txt').split(' ')
    self.guess_player = nil
    self.answer_player = nil
  end

  def create_comp_game()
    self.guess_player = ComputerPlayer.new(self, @dictionary)
    self.answer_player = HumanPlayer.new(self)
    set_opponents(guess_player, answer_player)
    p self.answer_player
    p self.human_player
  end

  def set_opponents(player1, player2)
    player1.set_opponent(player2)
    player2.set_opponent(player1)
  end

  def create_human_game()
    self.guess_player = HumanPlayer.new(self)
    self.answer_player = ComputerPlayer.new(self, @dictionary)
    set_opponents(guess_player, answer_player)
    p self.answer_player
    p self.human_player
  end

  def choose_game()
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
  end


end

if __FILE__ == $0
  hangman = Hangman.new
  p hangman.dictionary
  hangman.choose_game

end