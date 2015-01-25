##TODO
##1. victory?
##2. defeat?
##3. show a lot if zero
##4. identify flag input

require_relative "board"
require_relative "cell"

class Minesweeper
  def initialize
    puts "Welcome to Minesweeper! What a party is in store for yoU! You're a lucky guy!\nInput a number for the desired width of the board.\n"
    width = get_number
    puts "Input the desired height for the board!\n"
    height = get_number
    puts "Then, tell us how many mines you want to populate the board.\n"
    mines = get_number
    @session = Board.new(mines, width, height)
    run
  end


  def run
    while true
      if @session.victory?
        puts "hi"
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
