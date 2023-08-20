# frozen_string_literal: true

module StoplightAdmin
  module Application
    module Helpers
      COLORS = [
        GREEN = Stoplight::Color::GREEN,
        YELLOW = Stoplight::Color::YELLOW,
        RED = Stoplight::Color::RED
      ].freeze

      def dependencies
        StoplightAdmin::Dependencies.new(data_store: settings.data_store)
      end
    end
  end
end
