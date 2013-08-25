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
    guess_index = []
    if self.target_word.include? guess
      target_word.split('').each_with_index do |letter, index|
        if letter == guess
          guess_index << index
        end
      end
    end
    guess_index
  end

  def notify_opponent_of_target(size)
    @freq_hash = generate_freq_hash(size)
  end

  def generate_freq_hash(word_length)
    eligible_words = []
    @dictionary.each do |word|
      if word.size == word_length
        eligible_words << word
      end
    end
    word_arr = []
    eligible_words.each { |word| word_arr << word.split('').flatten }
    word_arr = word_arr.flatten
    hash_key = ('a'..'z').to_a
    freq_hash = {}
    word_arr.each do |letter|
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

    p freq_hash
    max = nil
    not_guessed.each do |key|
      if max == nil
        max = key
      elsif freq_hash[max] < freq_hash[key]
        max = key
      end
    end
    return max
  end


end
