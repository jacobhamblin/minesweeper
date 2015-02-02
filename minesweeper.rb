##TODO
##1. victory? -done
##2. defeat? -done
##3. show a lot if zero -done
##4. identify flag input
##5. make input easier

require_relative "board"
require_relative "cell"

class Minesweeper
  def initialize
    puts "\n\n\nWelcome to Minesweeper!"
    run
  end

  def reset
    puts 'Play again? y/n'
    input = gets.chomp
    case input
    when "y"
      run
    else
      puts "Thanks for playing!"
      exit
    end
  end

  def run
    puts "\nInput a number for the desired width of the board.\n"
    width = get_number
    puts "Input the desired height for the board!\n"
    height = get_number
    puts "Then, tell us how many mines you want to populate the board.\n"
    mines = get_number
    @session = Board.new(mines, width, height)
    while true
      if @session.victory?
        puts "\n"
        @session.display
        puts "\nYou've won!"
        reset
      end
      
      if @session.defeat?
        puts "\n"
        @session.reveal_mines
        @session.display
        puts "\nA mine!\n\nGame over.\n"
        reset
      end

      @session.display
      puts "What is the X coordinate of your next move?\n"
      x_coord = get_number
      puts "What is the Y coordinate of your next move?\n"
      y_coord = get_number
      @session.sweep(x_coord-1, y_coord-1)

    end
  end


  def get_number
    while true
      input = gets.chomp
      case input
      when "exit"
        exit
      when /\d*/
        if input.to_i == 0
          puts "wrong answer >:[\n"
          break
        end
        return input.to_i
      else
        puts "Your input is invalid./n"
      end
    end
  end
end

Minesweeper.new
