require './Player'
require './ComputerPlayer'
require './HumanPlayer'

class Hangman

  attr_accessor :dictionary, :guess_player, :answer_player

  def initialize
    self.dictionary = File.read('dictionary.txt').split(' ')
    self.guess_player = nil
    self.answer_player = nil
  end

end

if __FILE__ == $0
  hangman = Hangman.new
  p hangman.dictionary
end