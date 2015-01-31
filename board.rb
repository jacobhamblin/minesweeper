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
      xi, yi = initial_input
      unless @grid[x][y].mine? || ( x.between?(xi-1,xi+1) && y.between?(yi-1,yi+1) )
        @grid[x][y].set_mine
        i += 1
      end
    end
  end

  def nearby_mines(x, y)
    ([[-1,1],[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0]]).select do |x_adjust, y_adjust|
      @grid[x + x_adjust][y + y_adjust].mine? if in_bounds(x + x_adjust, y + y_adjust)
    end.count
  end

  def check_nearby_mines(x, y)
    ([[-1,1],[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0]]).each do |x_adjust, y_adjust|
      next unless in_bounds(x + x_adjust, y + y_adjust)
      cell = @grid[x + x_adjust][y + y_adjust]
      next if cell.checked
      cell.checked = true
      cell.set_revealed if in_bounds(x + x_adjust, y + y_adjust) && nearby_mines(x, y) == 0
      check_nearby_mines(x + x_adjust, y + y_adjust) if nearby_mines(x + x_adjust, y + y_adjust) == 0
    end
  end

  def sweep(x, y)
    raise "Enter a number within the scope of your game board." unless in_bounds(x,y)
    add_mines([x, y]) unless @grid.flatten.any? { |cell| cell.revealed? }
    @grid[x][y].set_revealed
    check_nearby_mines(x, y)
    @grid.flatten.each {|cell| cell.checked = false }
  end

  def in_bounds(col, row)
    col.between?(0,@width-1) && row.between?(0,@height-1)
  end

  def victory?
    @grid.flatten.none? { |cell| cell.empty? && !cell.revealed? }
  end

  def defeat?
    @grid.flatten.any? { |cell| cell.mine? && cell.revealed? }
  end

  def display_dev
    puts "\n"
    (0..@height-1).reverse_each do |row|
      line = []
      @grid.each_with_index do |column, ci|
        if column[row].mine?
          line << :X
        else
          line << nearby_mines(ci,row)
        end
      end
      puts line.join
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
