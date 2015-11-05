class ReportRobotCommand
  def initialize(robot, table)
    @robot, @table = robot, table
  end

  def execute(command)
    puts @robot.report
  end
end
