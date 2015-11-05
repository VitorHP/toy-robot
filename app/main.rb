require_relative 'robot.rb'
require_relative 'table.rb'
require_relative 'safe_trip_command_parser.rb'

if File.exists?(ARGV.first)
  SafeTripCommandParser.new(Robot.new, Table.new)
    .execute(File.readlines(ARGV.first))
else
  puts "Valid filename required as a param!"
end


