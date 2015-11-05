class TurnRobotCommand
  def initialize(robot, table)
    @robot, @table = robot, table
  end

  def execute(command)
    arguments = /^(LEFT|RIGHT)$/.match(command).captures

    @robot.turn(arguments.first)
  end
end
