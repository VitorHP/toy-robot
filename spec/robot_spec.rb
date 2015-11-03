require_relative '../app/robot.rb'

describe Robot do
  let(:robot_n){ Robot.new.place(0, 0, 'NORTH') }
  let(:robot_s){ Robot.new.place(0, 0, 'SOUTH') }
  let(:robot_e){ Robot.new.place(0, 0, 'EAST') }
  let(:robot_w){ Robot.new.place(0, 0, 'WEST') }


  describe '#place' do
    it 'only accepts valid orientations' do
      expect(robot_n).to be_an_instance_of(Robot)
      expect(robot_s).to be_an_instance_of(Robot)
      expect(robot_e).to be_an_instance_of(Robot)
      expect(robot_w).to be_an_instance_of(Robot)
      expect{Robot.new.place(0, 0, 'DOWN')}.to raise_error(ArgumentError)
    end

    it 'tracks its position and orientation' do
      robot = Robot.new.place(2, 1, 'NORTH')
      expect(robot.x).to eq(2)
      expect(robot.y).to eq(1)
      expect(robot.f).to eq('NORTH')
    end
  end

  describe '#calculate movement' do
    it 'returns the position of the robot after a possible movement' do
      expect(robot_n.calculate_movement).to eq([0, 1])
      expect(robot_s.calculate_movement).to eq([0, -1])
      expect(robot_e.calculate_movement).to eq([1, 0])
      expect(robot_w.calculate_movement).to eq([-1, 0])
    end
  end

  describe '#move' do
    it 'is ignored unless the robot is placed' do
      robot = Robot.new.move
      expect(robot.x).to eq(nil)
      expect(robot.y).to eq(nil)
    end

    it 'moves the robot in the direction it is facing' do
      expect(robot_n.move.x).to eq(0)
      expect(robot_n.y).to eq(1)

      expect(robot_s.move.x).to eq(0)
      expect(robot_s.y).to eq(-1)

      expect(robot_e.move.x).to eq(1)
      expect(robot_e.y).to eq(0)

      expect(robot_w.move.x).to eq(-1)
      expect(robot_w.y).to eq(0)
    end
  end

  describe '#turn' do
    it 'is ignored unless the robot is placed' do
      robot = Robot.new.turn
      expect(robot.f).to eq(nil)
    end

    it 'accept only valid directions' do
      expect{robot_n.turn('BACK')}.to raise_error(ArgumentError)
    end

    it 'turns the robot in 90 degrees steps' do
      expect(robot_n.turn('RIGHT').f).to eq('EAST')
      expect(robot_n.turn('RIGHT').f).to eq('SOUTH')
      expect(robot_n.turn('RIGHT').f).to eq('WEST')
      expect(robot_n.turn('RIGHT').f).to eq('NORTH')

      expect(robot_n.turn('LEFT').f).to eq('WEST')
      expect(robot_n.turn('LEFT').f).to eq('SOUTH')
      expect(robot_n.turn('LEFT').f).to eq('EAST')
      expect(robot_n.turn('LEFT').f).to eq('NORTH')
    end
  end

  describe '#report' do
    it "is ignored unless the robot is placed" do
      expect(Robot.new.report).not_to be_an(Array)
    end

    it "returns the robot's current position and orientation" do
      expect(Robot.new.place(0, 0, 'NORTH').report).to eq([0, 0, 'NORTH'])
    end
  end
end
