class Cell
  def initialize
    @mine = false
    #states: 1 = not revealed, 2 = flag, 3 = revealed
    @state = 1
  end

  def mine?
    @mine
  end

  def revealed?
    @state == 3
  end

  def set_revealed
    @state = 3
  end

  def flag?
    @state == 2
  end

  def set_mine
    @mine = true
  end
end