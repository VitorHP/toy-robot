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

    @x, @y, @f = x.to_i, y.to_i, ORIENTATIONS.index(f)

    return self
  end

  def calculate_movement
    case f
      when NORTH
        return { x: x, y: y + 1 }
      when SOUTH
        return { x: x, y: y - 1 }
      when EAST
        return { x: x + 1, y: y }
      when WEST
        return { x: x - 1, y: y }
    end
  end

  def move
    @x, @y = calculate_movement.values_at(:x, :y)

    return self
  end

  def turn(direction)
    raise ArgumentError, "Invalid direction. Valid directions are: #{TURN_DIRECTIONS.join(', ')}" unless TURN_DIRECTIONS.include? direction

    offset = direction == LEFT ? -1 : 1

    @f = (offset + @f) % 4

    return self
  end

  def report
    { x: @x, y: @y, f: f}
  end

  private

  def self.ignore_unless_placed(*methods)
    define_ignored = -> (method, options = {}) do
      define_method(method.name) do |*args, &block|
        if @placed
          method.bind(self).(*args, &block)
        else
          return options[:returning] || self
        end
      end
    end

    methods.each do |name|
      if name.is_a? Hash
        name.each_pair do |method_name, options|
          method = instance_method(method_name)

          define_ignored.call(method, options)
        end
      else
        method = instance_method(name)

        define_ignored.call(method)
      end
    end
  end

  ignore_unless_placed :move, :turn, report: { returning: {} }, calculate_movement: { returning: [] }
end
