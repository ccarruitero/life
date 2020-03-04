require "spec_helper"

RSpec.describe Life::Game do
  let(:subject) { described_class.new(13, 10, 5) }

  it "creates correct grid" do
    expect(subject.grid.row_count).to eq(13)
    expect(subject.grid.column_count).to eq(10)
  end

  context "when pattern is a number" do
    let(:subject) { described_class.new(3, 3, 3) }

    it "seed correctly " do
      calculated_alive = 3 * 3 / 3
      living_cells = subject.grid.select(&:alive)
      expect(living_cells.count).to eq(calculated_alive)
    end
  end

  context "when pattern is an array" do
    let(:subject) { described_class.new(3, 3, [[1,2], [2,1]]) }

    it "seed only pattern coordinates" do
      living_cells = subject.grid.select(&:alive)
      expect(living_cells.count).to eq(2)

      expect(subject.grid[1,2].alive).to eq(true)
      expect(subject.grid[2,1].alive).to eq(true)
    end

    context "with coordinate outside grid" do
      let(:subject) { described_class.new(3, 3, [[1,2], [3,1]]) }

      it "only apply valid pattern coordinates" do
        living_cells = subject.grid.select(&:alive)
        expect(living_cells.count).to eq(1)
      end
    end
  end

  context "#live_neighbor_count" do
    let(:subject) { described_class.new(3, 3, 3) }

    it "return correct calculation" do
      cell = subject.grid[0,1]
      expect(subject.live_neighbor_count(cell)).to eq(2)

      cell = subject.grid[1,1]
      expect(subject.live_neighbor_count(cell)).to eq(3)

      cell = subject.grid[2,0]
      expect(subject.live_neighbor_count(cell)).to eq(0)
    end
  end

  context "#tick" do
    let(:subject) { described_class.new(3, 3, 3) }

    it "get next grid generation correctly" do
      living_count = subject.grid.select(&:alive).count
      expect(living_count).to eq(3)

      subject.tick
      living_count = subject.grid.select(&:alive).count
      expect(living_count).to eq(2)

      subject.tick
      living_count = subject.grid.select(&:alive).count
      expect(living_count).to eq(0)
    end
  end
end
