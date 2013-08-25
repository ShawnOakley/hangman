require './player.rb'

class HumanPlayer < Player

  attr_accessor :game, :target_size

  def initialize(game)
    self.game = game
    self.target_size = nil
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
      self.target_size = length.to_i
      self.target_size
    end
  end

  def validate_guess(guess)
    puts "The computer guessed #{guess}."
    puts "Does your word contain #{guess}?  Please enter yes or no:"
    response = gets.chomp
    if /yes/i.match response
      puts "Please enter what space or spaces where the letter is located. Separate the spaces with a comma (e.g., '1,2,3,4'):"
      indices = gets.chomp
      if indices.split(',').any? {|num| /\D/i.match num}
        puts "Invalid input.  Please re-enter input."
        validate_guess(guess)
      elsif indices.split(',').any? {|num| num.to_i > self.target_size}
        puts "You entered a number that is longer than the target word.  Please re-enter input."
        validate_guess(guess)
      else
        return indices.split(',').map {|num| num.to_i - 1}
      end
    elsif /no/i.match response
      return []
    else
      puts "Invalid input.  Please re-enter input."
      validate_guess(guess)
    end
  end


  # The following methods are used when the human is designated as guessing player

  def make_guess(not_guessed)
    puts "The following letters are available:"
    print not_guessed.join(' ')
    puts
    puts "Please enter your guess:"
    guess = gets.chomp
    if /^[a-z]$|^[A-Z]$/.match guess
      guess.downcase
    else
      puts "Please only enter a single character length for the target word."
      make_guess(not_guessed)
    end
  end

  def notify_opponent_of_target(size)
    puts "The target is #{size} characters long."
  end


end