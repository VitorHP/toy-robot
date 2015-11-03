require_relative '../app/command_parser.rb'

describe CommandParser do

  let(:robot) { double('robot') }
  let(:table) { double('table') }

  let(:command_parser) { CommandParser.new(robot, table) }

  describe '#execute' do

    describe 'PLACE command' do
      let(:command) { ["PLACE 2,1,NORTH"] }

      it 'executes a PLACE command on the robot' do
        allow(table).to receive(:over_the_edge?).and_return(false)

        expect(robot).to receive(:place).with("2", "1", "NORTH")
        command_parser.execute(command)
      end

      it 'only executes when location provided is within the table borders' do
        allow(table).to receive(:over_the_edge?).and_return(true)

        expect(robot).not_to receive(:place)
        command_parser.execute(command)
      end
    end

    describe 'MOVE command' do
      let(:command) { ["MOVE"] }

      before do
        allow(robot).to receive(:calculate_movement)
      end

      it 'executes a MOVE command on the robot' do
        allow(table).to receive(:over_the_edge?).and_return(false)

        expect(robot).to receive(:move)
        command_parser.execute(command)
      end

      it 'only executes when the movement will not make the robot fall from the table' do
        allow(table).to receive(:over_the_edge?).and_return(true)

        expect(robot).not_to receive(:move)
        command_parser.execute(command)
      end
    end

    describe 'TURN command' do
      let(:command) { ["LEFT"] }

      it 'executes a TURN command on the robot' do
        expect(robot).to receive(:turn).with('LEFT')
        command_parser.execute(command)
      end
    end

    describe 'REPORT command' do
      let(:command) { ["REPORT"] }

      it 'executes a REPORT command on the robot' do
        expect(robot).to receive(:report)
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
