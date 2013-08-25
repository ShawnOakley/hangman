require './player.rb'

class ComputerPlayer < Player
  attr_accessor :dictionary, :target_word, :possible_guesses, :freq_hash

  def initialize (dictionary, game)
    self.dictionary = dictionary
    self.target_word = set_target_word(self.dictionary)
    self.possible_guesses = []
    self.game = game
  end

  def analyze_word_length(letter_count)
    self.possible_guesses = self.dictionary.select do |word|
                        word.length == letter_count
                     end
  end

  def generate_frequency_hash
    if self.freq_hash == nil
       dict_letters = self.possible_guesses.map { |word| word.split("") }.flatten
      self.freq_hash = Hash[("a".."z").zip([0]*26)]
      dict_letters.each do |letter|
      self.freq_hash[letter] = self.freq_hash[letter] + 1 if self.freq_hash[letter] != nil
     end
    end
  end

  def analyze_letter_frequency

    choice = self.freq_hash.collect{ |key,value| key if value == self.freq_hash.values.max }.compact.join('')
    self.freq_hash[choice] = 0
    choice
 end


  def set_target_word(dictionary)
    self.dictionary.sample.downcase.split("")
  end

  def validate_guess(letter)
   if /[a-z-]/.match(letter) && letter.size == 1
      process_letter(letter)
   else
     puts 'Invalid selection.  Only input alphabetic characters.  Only input a single character.'
      self.opponent.select_guess
   end
  end

  def process_letter(letter)
    if self.target_word.include? (letter)
      # Calls update_turn in Game class, which in turn checks
      # for winning.  If not winning, then update_turn calls select_guess
      # else plays 'You win!' script
      self.game.update_state_human(letter)
    else
      puts "#{letter} is not in #{self.target_word}"
      self.opponent.select_guess
    end
  end


end
