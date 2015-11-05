require_relative 'commands/place_robot_safely_command.rb'
require_relative 'commands/turn_robot_command.rb'
require_relative 'commands/move_robot_safely_command.rb'
require_relative 'commands/report_robot_command.rb'

class SafeTripCommandParser

  def initialize(robot, table)
    @robot, @table = robot, table
  end

  def execute(commands)
    commands.each do |command|
      execute_command(command)
    end
  end

  private

  def execute_command(command)
    case true
      when (command =~ /PLACE/) != nil
        return PlaceRobotSafelyCommand.new(@robot, @table).execute(command)
      when (command =~ /(LEFT|RIGHT)/) != nil
        return TurnRobotCommand.new(@robot, @table).execute(command)
      when (command =~ /MOVE/) != nil
        return MoveRobotSafelyCommand.new(@robot, @table).execute(command)
      when (command =~ /REPORT/) != nil
        return ReportRobotCommand.new(@robot, @table).execute(command)
    end
  end

end
