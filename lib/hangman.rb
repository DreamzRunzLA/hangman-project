require "byebug"

class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    return DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    if attempted_chars.include?(char)
      return true
    else
      return false
    end
  end

  def get_matching_indices(char)
    if !@secret_word.include?(char)
      return []
    else
      ans = []
      @secret_word.split('').each_with_index do |ele, i|
        if ele == char
          ans << i
        end
      end
      return ans
    end
  end

  def fill_indices(char, arr)
    arr.each_with_index do |ele|
      @guess_word[ele] = char
    end
  end

  #PART 2

  def try_guess(char)
    if already_attempted?(char)
      puts 'that has already been attempted'
      return false
    else
      @attempted_chars << char
      matches = get_matching_indices(char)
      if matches != []
        fill_indices(char, matches)
        return true
      end
      @remaining_incorrect_guesses -= 1
      return true
    end
  end

  def ask_user_for_guess
    puts 'Enter a char:'
    input = gets.chomp
    try_guess(input)
  end

  def win?
    if @guess_word.join('') == @secret_word
      print 'WIN'
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      print 'LOSE'
      return true
    else
      return false
    end
  end

  def game_over?
    if win? || lose?
      puts @secret_word
      return true
    else
      return false
    end
  end

end
