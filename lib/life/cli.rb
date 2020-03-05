require "thor"
require_relative "./game"
require "pry"

module Life
  class CLI < Thor
    include Thor::Actions

    desc :new, "Start new game of life"
    option :height, type: :numeric, aliases: "-h", required: true
    option :width, type: :numeric, aliases: "-w", required: true
    option :seed_pattern, type: :string, aliases: "-s", required: true
    option :pattern_type, type: :string, enum: %w[numeric array], aliases: "-t", required: true
    def new
      pattern = parse_pattern(options[:seed_pattern], options[:pattern_type])
      game = Life::Game.new(options[:height], options[:width], pattern)

      loop do
        system "clear"
        game.print
        game.tick
        sleep(0.3)
      end
    rescue Interrupt
      say("Exiting..")
      say("Thanks for try the Game of Life")
    end

    no_tasks do
      def parse_pattern(pattern, pattern_type)
        case pattern_type
          when "numeric"
            pattern.to_i
          when "array"
            JSON.parse(pattern)
        end
      end
    end
  end
end
