
class Mastermind

    def initialize
        @feedback = []
    end

    def startGame
# start game logic

        self.show_rules
        @breaker = CodeBreaker.new
        @maker = CodeMaker.new
        @maker.create_code
        p @maker.code
        self.play_turn
        self.play_again?
    end

    def show_rules
        puts "------------------------------"
        puts "--- Welcome to Mastermind! ---"
        puts "------------------------------"
        puts ""
        puts "Rules: "
        puts "A 4 colour code has been selected by the code maker."
        puts "As the code breaker you must pick 4 colours in a sequence to " + 
        "guess the code. There are no duplicate colors. You have 12 tries."
        puts ""
        puts "There are 6 colours to choose from:"
        puts "r - red       y - yellow"
        puts "g - green     c - cyan"
        puts "b - blue      m - magenta"
        puts ""
        puts "Feedback will be shown after each guess as a number of symbols:"
        puts "X - one of the guesses is the correct color and position"
        puts "O - one of the guesses is the correct color only"
        puts ""
    end

    def check_win(guess, code) 
        #check if code matches guess
        #if so, display win message
        if guess == code
            if 12 - @breaker.tries == 1
                puts "Amazing! You won in #{12 - @breaker.tries} turn!"
            else
                puts "Not bad! You won in #{12 - @breaker.tries} turns!"
            end
            return true
        end
    end

    def check_code(guess, code)
# check if guess matches code
    # if same colors and index: push X to feedback array
    # if only same colors and index different: push O to feedback array
        @feedback = []
        guess.each_with_index do |color, i|
            if color == code[i]
                @feedback << 'X'
            elsif code.include?(color)
                @feedback << 'O'
            end
        end
        return @feedback.sort.reverse.join
    end

    def play_turn   #play turn if tries are above zero
                    #take guess and display feedback
                    #check for win each guess
                    #once tries reach zero, display loss
        while @breaker.tries > 0 
            puts "      Your guess: #{@breaker.guess_code(@maker.colors)}" + 
            "       Feedback: #{self.check_code(@breaker.guess, @maker.code)}"
            puts ""
            if check_win(@breaker.guess, @maker.code) == true
                break
            end
        end
        if @breaker.tries == 0
            puts "Bad Luck. You lose!"
        end
    end

    def play_again? #prompt to ask to play again
                    #if yes; reload game, if no; exit game
        puts "Do you wish to play again? y/n?"
        input = gets.chomp.to_s
        if input.downcase == "y" || input.downcase == "yes"
            game = Mastermind.new
            game.startGame
        elsif input.downcase == "n" || input.downcase == "no"
            puts "Thank you for playing!"
            exit
        else
            puts "I don't understand."
            play_again?
        end
    end

end

class CodeBreaker
    attr_accessor :guess, :tries
    def initialize
        @guess = []
        @tries = 12
    end


    def guess_code(colors)
        # receive input from player eg: ( r b g m )
        # check for valid input ( 4 colors only, first letter)
        puts "Pick 4 colors in sequence eg: rgbc    Tries left: #{@tries}"
        @guess = gets.chomp.chars
        while @guess.map { |c| colors.include?(c) }.include?(false)
            puts "Invalid input! Try again:"
            @guess = gets.chomp.chars
        end
        @tries -= 1
        return @guess.join
    end

end

class CodeMaker
    attr_accessor :code, :colors
    def initialize
        @colors = ['r','g','b','y','c','m']
        @code = []
    end

    def create_code
    # generate random color from color list
    # if color not in code, push to code
    # do this until code is 4 colors in length
        while @code.length < 4
            @random = @colors.sample
            unless @code.include?(@random)
                @code << @random
            end
        end
    end

end

game = Mastermind.new
game.startGame

# display color options and rules
# display feedback display x = correct color & position
#                          o = correct color only

# code maker generates code and prints that this has been done

# receive input from player
# check for valid input ( 4 colors only, first letter)

# check if guess matches code
    # if same colors and index: print x, print # tries left
    # if only same colors and index different, print o, print tries
    # if all colors and index the same: print "you win" 
        # end game or replay

# code above repeated 12 times if no win reached
# print "you lose!" and end game or replay