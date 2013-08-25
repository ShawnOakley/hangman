require './player.rb'

class HumanPlayer < Player

  def initialize(game)
    self.game = game
  end


  # The following methods are used when the human IS designated as player

  def select_guess
    puts 'Please enter a guess:'
    letter = gets.chomp.downcase
    p letter
    p letter.size
    p letter.class
    self.opponent.validate_guess(letter)
  end

  # The following methods are used when the human IS
  # NOT designated as player

end