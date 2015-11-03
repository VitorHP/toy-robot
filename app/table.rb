class Table
  DEFAULT_DIMENSIONS = [5, 5]

  attr_reader :x, :y

  def initialize
    @x, @y = DEFAULT_DIMENSIONS
  end

  def over_the_edge?(x, y)
    !(0..@x).include?(x) || !(0..@y).include?(y)
  end

end
