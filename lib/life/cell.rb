module Life
  # Represent a Cell in Game of Life's grid
  # Only parameter that receive for initialize new instance is a Hash of options
  # Available options:
  # * alive: boolean => Cell's state.
  # * row: integer => Cell's row in the grid
  # * column: integer => Cell's column in the grid
  class Cell
    attr_reader :alive, :row, :column

    def initialize(opts = {})
      @alive = opts[:alive] || false
      @row = opts[:row]
      @column = opts[:column]
    end

    def display
      @alive ? "\u25A0" : "\u25A1" 
    end

    def live
      @alive = true
    end

    def die
      @alive = false
    end
  end
end
