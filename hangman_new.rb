class Hangman

  attr_accessor :dictionary, :guess_player, :answer_player

  def initialize
    self.dictionary = File.read('dictionary.txt').split(' ')
    self.guess_player = nil
    self.answer_player = nil
  end

  def self.create_comp_game()
    self.guess_player = ComputerPlayer.new
    self.answer_player = HumanPlayer.new
  end

  def self.create_human_game()
    self.guess_player = HumanPlayer.new
    self.answer_player = ComputerPlayer.new
  end

  def choose_game()
    puts "Please choose who will guess (Computer or Human):"
    if /comp|computer/i.match(guessing_player)
      self.create_comp_game
    elsif /human|h|me/i.match(guessing_player)
      self.create_human_game
    else
      puts "Invalid input.  Please enter either 'Human' or 'Computer'."
      choose_game
    end
  end


end

if __FILE__ == $0
  hangman = Hangman.new
  p hangman.dictionary
end