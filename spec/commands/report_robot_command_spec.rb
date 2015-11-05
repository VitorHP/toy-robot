require_relative '../../app/commands/report_robot_command.rb'

describe ReportRobotCommand do

  let(:robot) { double('robot') }
  let(:table) { double('table') }
  let(:command) { "REPORT" }

  subject { ReportRobotCommand.new(robot, table) }

  it 'executes a REPORT command on the robot' do
    expect(robot).to receive(:report)
    subject.execute(command)
  end
end
