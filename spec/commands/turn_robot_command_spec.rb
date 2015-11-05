require_relative '../../app/commands/turn_robot_command.rb'

describe TurnRobotCommand do

  let(:robot) { double('robot') }
  let(:table) { double('table') }
  let(:command) { "LEFT" }

  subject { TurnRobotCommand.new(robot, table) }

  it 'executes a TURN command on the robot' do
    expect(robot).to receive(:turn).with('LEFT')
    subject.execute(command)
  end
end
