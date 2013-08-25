require './player.rb'

class ComputerPlayer < Player
  attr_accessor :dictionary, :target_word, :possible_guesses, :freq_hash

  def initialize (dictionary, game)
    self.dictionary = dictionary
    self.target_word = set_target_word(self.dictionary)
    self.possible_guesses = []
    self.game = game
  end




end
