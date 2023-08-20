# frozen_string_literal: true

module StoplightAdmin
  module Actions
    # This action locks all lights green
    class GreenAll < Action
      # @return [void]
      def call(*)
        lights_repository
          .with_color(RED, YELLOW)
          .map(&:name)
          .each { |name| lights_repository.lock(name, GREEN) }
      end
    end
  end
end
