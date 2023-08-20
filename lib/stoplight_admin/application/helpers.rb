# frozen_string_literal: true

module StoplightAdmin
  module Application
    module Helpers
      COLORS = [
        GREEN = Stoplight::Color::GREEN,
        YELLOW = Stoplight::Color::YELLOW,
        RED = Stoplight::Color::RED
      ].freeze

      def lights_repository
        StoplightAdmin::LightsRepository.new(data_store: data_store)
      end

      def data_store
        return @data_store if defined?(@data_store)
        @data_store = Stoplight.default_data_store = settings.data_store
      end
    end
  end
end
