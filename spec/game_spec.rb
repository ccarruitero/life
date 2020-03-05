require "spec_helper"

RSpec.describe Life::Game do
  let(:subject) { described_class.new(3, 3, 3) }
  let(:grid) { subject.grid }
  let(:living_cells) { grid.select(&:alive) }

  it "creates correct grid" do
    expect(grid.row_count).to eq(3)
    expect(grid.column_count).to eq(3)
  end

  context "when pattern is a number" do
    it "seed correctly " do
      expect(living_cells.count).to eq(3)
    end
  end

  context "when pattern is an array" do
    let(:subject) { described_class.new(3, 3, [[1,2], [2,1]]) }

    it "seed correct cells number" do
      expect(living_cells.count).to eq(2)
    end

    it "seed correct pattern coordinates" do
      expect(grid[1,2].alive).to eq(true)
    end

    context "with coordinate outside grid" do
      let(:subject) { described_class.new(3, 3, [[1,2], [3,1]]) }

      it "only apply valid pattern coordinates" do
        expect(living_cells.count).to eq(1)
      end
    end
  end

  context "#live_neighbor_count" do
    it "return correct calculation" do
      cell = grid[0,1]
      expect(subject.live_neighbor_count(cell)).to eq(2)
    end
  end

  context "#tick" do
    it "get next grid generation correctly" do
      subject.tick
      expect(living_cells.count).to eq(2)
    end
  end
end
