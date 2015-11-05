class PlaceRobotSafelyCommand
  def initialize(robot, table)
    @robot, @table = robot, table
  end

  def execute(command)
    arguments = /^PLACE (\d),(\d),(\w+)$/.match(command).captures

    @robot.place(*arguments) unless @table.over_the_edge?(*arguments[0..1])
  end
end
