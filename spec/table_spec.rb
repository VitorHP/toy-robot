require_relative '../app/table.rb'

describe Table do
  let(:table) { Table.new }

  it 'has dimensions of 5x5' do
    expect(table.x).to eq(5)
    expect(table.y).to eq(5)
  end

  describe '#over_the_edge?' do
    it "returns true for a position over the table's boundaries" do
      expect(table.over_the_edge?(5, 5)).to eq(false)
      expect(table.over_the_edge?(7, 5)).to eq(true)
    end
  end

end
