module Life
  # Utility methods
  module Utils
    module_function

    def apply_rules(cell, next_grid, living_neighbors)
      next_cell = next_grid[cell.row, cell.column]

      if cell.alive
        next_cell.die unless (2..3).include?(living_neighbors)
      else
        next_cell.live if living_neighbors === 3
      end
    end

    def neighbor_positions(cell)
      positions = [-1, 0, 1]

      positions.product(positions)
        .reject { |position| position == [0,0] }
        .map { |row, column| [cell.row + row, cell.column + column] }
    end
  end
end
