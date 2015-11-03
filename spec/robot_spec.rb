require_relative '../app/robot.rb'

describe Robot do
  let(:robot_n){ Robot.new(0, 0, 'NORTH') }
  let(:robot_s){ Robot.new(0, 0, 'SOUTH') }
  let(:robot_e){ Robot.new(0, 0, 'EAST') }
  let(:robot_w){ Robot.new(0, 0, 'WEST') }

  it 'tracks its position and orientation' do
    robot = Robot.new(2, 1, 'NORTH')
    expect(robot.x).to eq(2)
    expect(robot.y).to eq(1)
    expect(robot.f).to eq('NORTH')
  end

  it 'only accepts valid orientations' do
    expect(robot_n).to be_an_instance_of(Robot)
    expect(robot_s).to be_an_instance_of(Robot)
    expect(robot_e).to be_an_instance_of(Robot)
    expect(robot_w).to be_an_instance_of(Robot)
    expect{Robot.new(0, 0, 'DOWN')}.to raise_error(ArgumentError)
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
end
