require_relative '../../app/commands/move_robot_safely_command.rb'

describe MoveRobotSafelyCommand do

  let(:robot) { double('robot') }
  let(:table) { double('table') }
  let(:command) { "MOVE" }

  subject { MoveRobotSafelyCommand.new(robot, table) }

  before do
    allow(robot).to receive(:calculate_movement).and_return({})
  end

  it 'executes a MOVE command on the robot' do
    allow(table).to receive(:over_the_edge?).and_return(false)

    expect(robot).to receive(:move)
    subject.execute(command)
  end

  it 'only executes when the movement will not make the robot fall from the table' do
    allow(table).to receive(:over_the_edge?).and_return(true)

    expect(robot).not_to receive(:move)
    subject.execute(command)
  end
end
