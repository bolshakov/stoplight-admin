# frozen_string_literal: true

module StoplightAdmin
  module Actions
    class Home
      # @!attribute lights_repository
      #   @return [StoplightAdmin::LightsRepository]
      attr_reader :lights_repository
      private :lights_repository

      # @!attribute lights_stats
      #   @return [StoplightAdmin::LightsStats]
      attr_reader :lights_stats
      private :lights_stats

      # @return lights_repository [StoplightAdmin::LightsRepository]
      # @param lights_stats [Class<StoplightAdmin::LightsStats>]
      def initialize(lights_repository:, lights_stats:)
        @lights_repository = lights_repository
        @lights_stats = lights_stats
      end

      # @return [(StoplightAdmin::LightsRepository::Light)]
      def call
        lights = lights_repository.all
        stats = lights_stats.call(lights)
        [lights, stats]
      end
    end
  end
end
