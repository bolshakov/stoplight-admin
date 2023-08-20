# frozen_string_literal: true

module StoplightAdmin
  module Actions
    # This action locks all lights green
    class GreenAll
      # @!attribute lights_repository
      #   @return [StoplightAdmin::LightsRepository]
      attr_reader :lights_repository
      private :lights_repository

      # @return lights_repository [StoplightAdmin::LightsRepository]
      def initialize(lights_repository:)
        @lights_repository = lights_repository
      end

      # @return [void]
      def call
        lights_repository
          .with_color(RED, YELLOW)
          .map(&:name)
          .each { |name| lights_repository.lock(name, GREEN) }
      end
    end
  end
end
