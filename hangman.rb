class Hangman

  attr_accessor :dictionary, :target_word, :computer_player, :human_player, :current_state, :current_player

  def initialize
    self.dictionary = File.read('dictionary.txt').split(" ")
    self.human_player = HumanPlayer.new(self)
    self.computer_player = ComputerPlayer.new(self.dictionary, self)
    self.target_word = self.computer_player.target_word
    self.current_state = []
    self.current_player = []
  end

  def setup
    introduce_opponents(self.human_player, self.computer_player)
  end

  def introduce_opponents(human_player, computer_player)
    human_player.opponent = computer_player
    computer_player.opponent = human_player
  end

  def choose_game()

    setup
    puts "Please choose who will guess (Computer or Human):"
    player = gets.chomp.downcase

    #  MAIN LOOP FOR HUMAN PLAYER

    if /human/.match(player)
      target_word.size.times { self.current_state << "_"}
      self.current_player = self.human_player
      self.current_player.select_guess

    #  MAIN LOOP FOR COMPUTER PLAYER

    elsif /computer/.match(player)
      self.current_player = self.computer_player
      self.current_player.generate_frequency_hash
      puts "How many letters are in your word?"
      length = gets.chomp.to_i
      length.times { self.current_state << "_"}
      self.current_player.analyze_word_length(length)
      while !win_check_computer(self.current_state.join(""))
        guess = self.current_player.analyze_letter_frequency
        reply_check(guess)
      end

    end
  end

  def reply_check(guess)
    puts "Is #{guess} in your word?"
    reply = gets.chomp
    if /^yes$|^y$/i.match(reply)
      puts "Where is/are the letter(s) located? Please separate multiple entries with commas."
      positions = gets.chomp.split(',')
      update_state_computer(positions, guess)
      puts self.current_state.join(' ')
    elsif /^no$|^n$/i.match(reply)
      puts "Too bad.  I'll guess again."
    else
      puts "Invalid input.  Please either enter 'Yes' or 'No'."
      reply_check(guess)
    end
  end


  def update_state_human(letter)
    update_board(letter)
    word = self.current_state.join(' ')
    p word
    win_check(word)
  end

  def update_state_computer(positions, guess)
    positions.each{ |position| @current_state[position.to_i-1] = guess}
  end


  def update_board(letter)
    if self.current_state.include?(letter)
      puts "Already guessed.  Guess something else."
      self.current_player.select_guess
    else self.target_word.each_with_index do |l, index|
      self.current_state[index] = letter if l.match(letter)
      end
    end
  end

  def win_check_computer(word)

    if /^[^_]+$/.match(word)
      p "Computer wins.  The word was #{word}."
      return true
    else
      return false
    end
  end

  def win_check(word)

    if /^[^_]+$/.match(word)
      p "You win.  The word was #{word}."
    else
      self.current_player.select_guess
    end
  end

end

class Player

  attr_accessor :opponent, :game

  def initialize()
    self.opponent = nil
  end

  def set_opponent(opponent)
    self.opponent = opponent
  end
end

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

 hangman = Hangman.new
 hangman.choose_game
# p hangman.computer_player.target_word
# hangman.human_player.select_guess
# p hangman.dictionary[1111]