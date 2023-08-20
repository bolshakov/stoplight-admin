# frozen_string_literal: true

module StoplightAdmin
  module Actions
    class Home < Action
      # @!attribute lights_stats
      #   @return [StoplightAdmin::LightsStats]
      attr_reader :lights_stats
      private :lights_stats

      # @param lights_stats [Class<StoplightAdmin::LightsStats>]
      def initialize(lights_stats:, **deps)
        super(**deps)
        @lights_stats = lights_stats
      end

      # @return [(StoplightAdmin::LightsRepository::Light)]
      def call(*)
        lights = lights_repository.all
        stats = lights_stats.call(lights)
        [lights, stats]
      end
    end
  end
end
