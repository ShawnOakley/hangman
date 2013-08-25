require './player.rb'

class ComputerPlayer < Player
  attr_accessor :dictionary, :target_word, :possible_guesses, :freq_hash

  def initialize (dictionary, game)
    self.dictionary = dictionary
    self.possible_guesses = []
    self.game = game
    self.target_word = nil
  end

    # The following methods are used when the human is designated as answering player

  def generate_target
    # generates target by randomly selecting word from dictionary
    # sets to target_word variable
    # returns length of word
    self.target_word = dictionary[(0...dictionary.size).to_a.sample]
    self.target_word.size
  end

  def validate_guess(guess)

  end

  def notify_opponent_of_target(size)
    generate_freq_hash(size)
  end

  def generate_freq_hash(word_length)
    eligible_words = []
    dictionary.each do |word|
      if word.size == word_length
        eligible_words << word
      end
    end
    eligible_words.map { |word| split('') }.flatten
    hash_key = ('a'..'z').to_a
    freq_hash = {}
    eligibile_words.each do |letter|
      if freq_hash[letter] == nil
        freq_hash[letter] = 0
      end
      freq_hash[letter] += 1
    end
    freq_hash
  end


    # The following methods are used when the human is designated as guessing player





  def make_guess(not_guessed)
    puts "The following letters are available:"
    print not_guessed.join(' ')
    puts
    return not_guessed.sample
  end


end
