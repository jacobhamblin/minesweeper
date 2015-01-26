class Board
  def initialize(mines, width, height)
    @mines = mines
    @width = width
    @height = height
    @grid = Array.new(@width) { Array.new(@height) { Cell.new }}
  end

  def add_mines(initial_input)
    i = 0
    until i == @mines
      x = rand(@width)
      y = rand(@height)
      unless @grid[x][y].mine? || [x,y] == initial_input
        @grid[x][y].set_mine
        i += 1
      end
    end
  end

  def sweep(x, y)
    add_mines([x, y]) unless @grid.flatten.any? { |cell| cell.revealed? }
    @grid[x][y].set_revealed
  end

  def in_bounds(col, row)
    col.between?(0,@width-1) && row.between?(0,@height-1)
  end

  def victory?
    @grid.flatten.none? { |cell| !cell.mine? && !cell.revealed? }
  end

  def display_dev
    puts "\n"
    (0..@height-1).reverse_each do |row|
      line = []
      @grid.each_with_index do |column, ci|
        if column[row].mine?
          line << :X
        else
          nearby_mines = ([[-1,1],[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0]]).select do |x, y|
            @grid[ci + x][row + y].mine? if in_bounds(ci+x, row+y)
          end.count
          line << nearby_mines
        end
      end
      puts line.join()
    end
  end

  def display
    puts "-"*(@width+2)
    (0..@height-1).reverse_each do |row|
      line = []
      @grid.each_with_index do |column, ci|
        cell = column[row]
        if !cell.revealed?
          line << " "
        elsif cell.mine?
          line << :X
        elsif !cell.mine? && cell.revealed?
          nearby_mines = ([[-1,1],[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0]]).select do |x, y|
            @grid[ci + x][row + y].mine? if in_bounds(ci+x, row+y)
          end.count
          line << nearby_mines
        end
      end
      puts "|#{line.join()}|"
    end
    puts "-"*(@width+2)
  end
end
