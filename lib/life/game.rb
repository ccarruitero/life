require "matrix"
require_relative "./cell"

module Life
  class Game
    attr_reader :grid

    def initialize(height, width, pattern)
      @grid = Matrix.build(height, width) do |x, y|
        Cell.new({ row: x, column: y})
      end

      seed(pattern)
    end

    def seed(pattern)
      case pattern
        when Integer
          cells_count = 1
          @grid.each do |cell|
            cell.live if cells_count % pattern == 0
            cells_count += 1
          end
        when Array
          pattern.each do |row, column|
            @grid[row, column]&.live
          end
       end
    end

    def live_neighbor_count(cell)
      count = 0
      positions = [-1, 0, 1]

      positions.each do |row|
        positions.each do |column|
          next if row == 0 && column == 0

          neighbor_row = cell.row + row
          neighbor_column = cell.column + column

          next if off_grid(neighbor_row, neighbor_column)

          count += 1 if @grid[neighbor_row, neighbor_column].alive
        end
      end

      count
    end

    def tick
      next_grid = Marshal.load(Marshal.dump(@grid))

      @grid.each do |cell|
        living_neighbors = live_neighbor_count(cell)
        next_cell = next_grid[cell.row, cell.column]

        if cell.alive
          next_cell.die unless (2..3).include?(living_neighbors)
        else
          next_cell.live if living_neighbors === 3
        end
      end

      @grid = next_grid
    end

    def print
      @grid.to_a.each do |row|
        puts row.map(&:display).join(" ")
      end
    end

    private

    def off_grid(row, column)
      row < 0 || column < 0 || row > last("row") || column > last("column")
    end

    def last(property)
      @grid.send("#{property}_count") - 1
    end
  end
end
