# frozen_string_literal: true

module Sinatra
  module StoplightAdmin
    class LightsRepository
      class Light
        COLORS = [
          GREEN = Stoplight::Color::GREEN,
          YELLOW = Stoplight::Color::YELLOW,
          RED = Stoplight::Color::RED
        ].freeze

        # @!attribute name
        #   @return [String]
        attr_reader :name

        # @!attribute color
        #   @return [String]
        attr_reader :color

        # @!attribute state
        #   @return [String]
        attr_reader :state

        # @!attribute failures
        #   @return [<Stoplight::Failure>]
        attr_reader :failures

        # @param name [String]
        # @param color [String]
        # @param state [String]
        # @param failures [<Stoplight::Failure>]
        def initialize(name:, color:, state:, failures:)
          @name = name
          @color = color
          @state = state
          @failures = failures
        end

        # @return [Boolean]
        def locked?
          !unlocked?
        end

        # @return [Boolean]
        def unlocked?
          state == Stoplight::State::UNLOCKED
        end

        def as_json
          {
            name: name,
            color: color,
            failures: failures,
            locked: locked?
          }
        end

        # @return [Array]
        def default_sort_key
          [-COLORS.index(color), name]
        end
      end
    end
  end
end
