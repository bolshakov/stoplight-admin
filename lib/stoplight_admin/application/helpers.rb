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

      def lock(light)
        l = Stoplight::Light.new(light) {}
        new_state =
          case l.color
          when Stoplight::Color::GREEN
            Stoplight::State::LOCKED_GREEN
          else
            Stoplight::State::LOCKED_RED
          end

        data_store.set_state(l, new_state)
      end

      def unlock(light)
        l = Stoplight::Light.new(light) {}
        data_store.set_state(l, Stoplight::State::UNLOCKED)
      end

      def green(light)
        l = Stoplight::Light.new(light) {}
        if data_store.get_state(l) == Stoplight::State::LOCKED_RED
          new_state = Stoplight::State::LOCKED_GREEN
          data_store.set_state(l, new_state)
        end

        data_store.clear_failures(l)
      end

      def red(light)
        l = Stoplight::Light.new(light) {}
        data_store.set_state(l, Stoplight::State::LOCKED_RED)
      end

      def with_lights
        [*params[:names]]
          .map  { |l| CGI.unescape(l) }
          .each { |l| yield(l) }
      end
    end
  end
end
