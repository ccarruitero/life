module Life
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
