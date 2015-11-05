require_relative '../app/safe_trip_command_parser.rb'

describe SafeTripCommandParser do

  let(:robot) { double('robot') }
  let(:table) { double('table') }

  let(:command_parser) { SafeTripCommandParser.new(robot, table) }
  let(:command_object) { double('command_object') }

  describe '#execute' do

    describe 'PLACE command' do
      let(:command) { ["PLACE 2,1,NORTH"] }

      before do
        allow(PlaceRobotSafelyCommand).to receive(:new).and_return(command_object)
      end

      it 'Instantiates a command object and executes it' do
        expect(command_object).to receive(:execute).with(command.first)

        command_parser.execute(command)
      end
    end

    describe 'MOVE command' do
      let(:command) { ["MOVE"] }

      before do
        allow(MoveRobotSafelyCommand).to receive(:new).and_return(command_object)
      end

      it 'Instantiates a command object and executes it' do
        expect(command_object).to receive(:execute).with(command.first)

        command_parser.execute(command)
      end
    end

    describe 'TURN command' do
      let(:command) { ["LEFT"] }

      before do
        allow(TurnRobotCommand).to receive(:new).and_return(command_object)
      end

      it 'Instantiates a command object and executes it' do
        expect(command_object).to receive(:execute).with(command.first)

        command_parser.execute(command)
      end
    end

    describe 'REPORT command' do
      let(:command) { ["REPORT"] }

      before do
        allow(ReportRobotCommand).to receive(:new).and_return(command_object)
      end

      it 'Instantiates a command object and executes it' do
        expect(command_object).to receive(:execute).with(command.first)

        command_parser.execute(command)
      end
    end

    it 'executes many commands in sequence' do
      allow(table).to receive(:over_the_edge?).and_return(false)

      expect(robot).to receive(:place).with('2', '1', 'EAST')
      expect(robot).to receive(:turn).with('RIGHT')

      command_parser.execute(["PLACE 2,1,EAST", "RIGHT"])
    end
  end
end
