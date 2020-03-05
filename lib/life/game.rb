require "matrix"
require_relative "./cell"
require_relative "./utils"

module Life
  # Game is the core for this gem.
  # Is responsible to initialize and store the grid of cells, also provide
  # operations related to the grid, like calculate living neighbors or
  # tick for new generations
  # * height => height for Game of Life's grid
  # * height => width for Game of Life's grid
  # * pattern => could be a number or a 2d array for desired seed positions
  class Game
    include Utils

    attr_reader :grid

    def initialize(height, width, pattern)
      @grid = Matrix.build(height, width) do |row, column|
        Cell.new({ row: row, column: column})
      end

      seed(pattern)
    end

    def seed(pattern)
      case pattern
        when Integer
          seed_by_number(pattern)
        when Array
          seed_by_array(pattern)
       end
    end

    def live_neighbor_count(cell)
      count = 0

      neighbor_positions(cell).each do |neighbor_row, neighbor_column|
        next if off_grid(neighbor_row, neighbor_column)

        count += 1 if @grid[neighbor_row, neighbor_column].alive
      end

      count
    end

    def tick
      next_grid = Marshal.load(Marshal.dump(@grid))

      @grid.each do |cell|
        apply_rules(cell, next_grid, live_neighbor_count(cell))
      end

      @grid = next_grid
    end

    def print
      @grid.to_a.each do |row|
        puts row.map(&:display).join(" ")
      end
    end

    private

    def seed_by_number(pattern)
      @grid.to_a.flatten.each_with_index do |cell, index|
        cell.live if (index + 1) % pattern == 0
      end
    end

    def seed_by_array(pattern)
      pattern.each do |row, column|
        @grid[row, column]&.live
      end
    end

    def off_grid(row, column)
      row < 0 || column < 0 || row > last("row") || column > last("column")
    end

    def last(property)
      @grid.send("#{property}_count") - 1
    end
  end
end
