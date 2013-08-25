require './player.rb'

class HumanPlayer < Player

  attr_accessor :game, :target_word

  def initialize(game)
    self.game = game
    self.target_word = nil
  end

  # The following methods are used when the human is designated as answering player

  def generate_target
    # generates target by asking player to think of word
    # sets to target_word variable
    # returns length of word

    puts "Please think of a target word."
    puts "When ready, please enter the length of the target word:"
    length = gets.chomp

    if /\D/.match length
      puts "Please only enter an integer length for the target word."
      generate_target
    else
      length.to_i
    end
  end

  # The following methods are used when the human is designated as guessing player




end