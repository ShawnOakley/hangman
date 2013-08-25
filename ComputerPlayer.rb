require './player.rb'

class ComputerPlayer < Player
  attr_accessor :dictionary, :target_word, :possible_guesses, :freq_hash

  def initialize (dictionary, game)
    self.dictionary = dictionary
    self.possible_guesses = []
    self.game = game
    self.target_word = nil
  end

  def generate_target
    # generates target by randomly selecting word from dictionary
    # sets to target_word variable
    # returns length of word




  end


end
