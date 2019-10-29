class Hangman
  WORD_SELECTION = %w[addition obligation ability preparation insect family newspaper conclusion imagination decision diamond internet funeral recipe entry criticism city economics protection entertainment media foundation situation negotiation philosophy device village concept worker discussion apartment manufacturer teaching computer user memory direction birthday sector construction camera courage improvement variation guitar elevator appearance agreement property paper girlfriend orange supermarket intention preference setting moment engineering income hotel highway information cancer singer policy sister energy software performance presence industry advice communication resource people strategy area tension understanding attitude feedback writing promotion midnight activity difference studio dealer instance inspection basis application suggestion bedroom assistance airport signature weakness manager].freeze

  HANGMAN_PROGRESS = [
    "     ________
       :    |
       O    |
      /|\\   |
      / \\   |
    ________|
    ",
    "   ________
     :    |
     O    |
    /|\\   |
          |
  ________|
  ",
    "   ________
     :    |
     O    |
     |    |
          |
  ________|
  ",
    "   ________
     :    |
     O    |
          |
          |
  ________|
  ",
    "   ________
          |
          |
          |
          |
   _______|
  ",
    "
          |
          |
          |
          |
   _______|
  ",
    "



   --------
  "
  ].freeze

  def initialize
    @word = []
    @correct_guesses = []
    @max_guesses = 0
    @guess = ''
  end

  class << self
    def play
      @max_guesses = HANGMAN_PROGRESS.length
      @word = WORD_SELECTION.sample.split('')
      @correct_guesses = Array.new(@word.length, '_')
      until @max_guesses.zero?
        prompt_for_letter
        check_for_match
      end
    end

    def prompt_for_letter
      puts @correct_guesses.join(' ').upcase
      print 'Pick a letter: '
      @guess = gets.chomp
    end

    def check_for_match
      index = @word.each_index.select { |i| @word[i] == @guess }
      return update_correct_guesses(index) unless index.empty?
      return reduce_remaining_guesses if @max_guesses > 1

      exceeded_maximum_guesses
    end

    def check_for_success
      return unless @word == @correct_guesses

      @max_guesses = 0
      puts "\033[32m#{"Woohoo! You saved the man!"}\033[0m"
    end

    def update_correct_guesses(index)
      index.map { |i| @correct_guesses[i] = @guess }
      check_for_success
    end

    def exceeded_maximum_guesses
      @max_guesses = 0
      puts "\033[31m#{@word.join('').upcase}\033[0m"
      puts "\033[31m#{'Whelp, at least now you know what it\'s like to kill a man.'}\033[0m"
      puts "\033[31m#{HANGMAN_PROGRESS[0]}\033[0m"
    end

    def reduce_remaining_guesses
      @max_guesses -= 1
      puts "You have \033[31m#{@max_guesses}\033[0m incorrect guesses remaining."
      puts HANGMAN_PROGRESS[@max_guesses]
    end
  end
end

Hangman.new
Hangman.play
