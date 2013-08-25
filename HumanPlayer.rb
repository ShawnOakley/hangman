require './player.rb'

class HumanPlayer < Player

  attr_accessor :game, :target_word

  def initialize(game)
    self.game = game
    self.target_word = nil
  end


  def generate_target
    # generates target by asking player to think of word
    # sets to target_word variable
    # returns length of word


  end

  # The following methods are used when the human IS designated as player


  # The following methods are used when the human IS
  # NOT designated as player

end