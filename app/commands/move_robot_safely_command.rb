class MoveRobotSafelyCommand
  def initialize(robot, table)
    @robot, @table = robot, table
  end

  def execute(command)
    @robot.move unless @table.over_the_edge?(*@robot.calculate_movement.values_at(:x, :y))
  end
end
