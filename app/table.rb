class Table
  attr_reader :x, :y

  def initialize
    @x = 5
    @y = 5
  end

  def over_the_edge?(x, y)
    !(0..@x).include?(x) || !(0..@y).include?(y)
  end

end
