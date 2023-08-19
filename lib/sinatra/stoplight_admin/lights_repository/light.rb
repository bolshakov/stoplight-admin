# frozen_string_literal: true

module Sinatra
  module StoplightAdmin
    class LightsRepository
      Light = Struct.new(:name, :color, :state, :failures) do
        LOCKED_GREEN = Stoplight::State::LOCKED_GREEN
        LOCKED_RED = Stoplight::State::LOCKED_RED

        # @return [Boolean]
        def locked?
          [LOCKED_GREEN, LOCKED_RED].include?(color)
        end
      end
    end
  end
end
