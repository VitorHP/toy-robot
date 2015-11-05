require_relative '../../app/commands/place_robot_safely_command.rb'

describe PlaceRobotSafelyCommand do

  let(:robot) { double('robot') }
  let(:table) { double('table') }
  let(:command) { "PLACE 2,1,NORTH" }

  subject { PlaceRobotSafelyCommand.new(robot, table) }

  it 'executes a PLACE command on the robot' do
    allow(table).to receive(:over_the_edge?).and_return(false)

    expect(robot).to receive(:place).with("2", "1", "NORTH")
    subject.execute(command)
  end

  it 'only executes when location provided is within the table borders' do
    allow(table).to receive(:over_the_edge?).and_return(true)

    expect(robot).not_to receive(:place)
    subject.execute(command)
  end
end
