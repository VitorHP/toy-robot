class Robot
  NORTH = 'NORTH'
  SOUTH = 'SOUTH'
  EAST = 'EAST'
  WEST = 'WEST'
  ORIENTATIONS = [NORTH, EAST, SOUTH, WEST]

  LEFT = 'LEFT'
  RIGHT = 'RIGHT'
  TURN_DIRECTIONS = [LEFT, RIGHT]

  attr_reader :x, :y

  def f
    @f.nil? ? nil : ORIENTATIONS[@f]
  end

  def initialize
    @placed = false
  end

  def place(x, y, f)
    raise ArgumentError, "Invalid orientation. Valid orientations are: #{ORIENTATIONS.join(', ')}" unless ORIENTATIONS.include? f

    @placed = true

    @x, @y, @f = x, y, ORIENTATIONS.index(f)

    return self
  end

  def calculate_movement
    case f
      when NORTH
        return x, y + 1
      when SOUTH
        return x, y - 1
      when EAST
        return x + 1, y
      when WEST
        return x - 1, y
    end
  end

  def move
    @x, @y = calculate_movement

    return self
  end

  def turn(direction)
    raise ArgumentError, "Invalid direction. Valid directions are: #{TURN_DIRECTIONS.join(', ')}" unless TURN_DIRECTIONS.include? direction

    offset = direction == LEFT ? -1 : 1

    @f = (offset + @f) % 4

    return self
  end

  def report
    [@x, @y, f]
  end

  private

  def self.ignore_unless_placed(*methods)
    methods.each do |name|
      method = instance_method(name)
      define_method(name) do |*args, &block|
        if @placed
          method.bind(self).(*args, &block)
        else
          return self
        end
      end
    end
  end

  ignore_unless_placed :move, :turn, :report

end
