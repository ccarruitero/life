require "thor"
require_relative "./game"
require_relative "./utils"

module Life
  # A CLI to use Life::Game
  class CLI < Thor
    include Thor::Actions
    include Utils

    desc :new, "Start new Game of Life"
    option :height, type: :numeric, aliases: "-h", required: true
    option :width, type: :numeric, aliases: "-w", required: true
    option :seed_pattern, type: :string, aliases: "-s", required: true
    option :pattern_type, type: :string, enum: %w[numeric array], aliases: "-t", required: true
    def new
      pattern = parse_pattern(options[:pattern_type], options[:seed_pattern])
      game = Life::Game.new(options[:height], options[:width], pattern)
      run_game(game)
    rescue Interrupt
      say("Exiting..")
      say("Thanks for try the Game of Life")
    end
  end
end
