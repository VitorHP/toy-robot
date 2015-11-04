require 'pry'

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
        return place_robot command
      when (command =~ /(LEFT|RIGHT)/) != nil
        return turn_robot command
      when (command =~ /MOVE/) != nil
        return move_robot
      when (command =~ /REPORT/) != nil
        return report_robot
    end
  end

  def place_robot(command)
    arguments = /^PLACE (\d),(\d),(\w+)$/.match(command).captures

    @robot.place(*arguments) unless @table.over_the_edge?(*arguments[0..1])
  end

  def turn_robot(command)
    arguments = /^(LEFT|RIGHT)$/.match(command).captures

    @robot.turn(arguments.first)
  end

  def move_robot
    @robot.move unless @table.over_the_edge?(*@robot.calculate_movement)
  end

  def report_robot
    puts @robot.report
  end

end
