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

      def stat_params(ls)
        h = {
          count_red: 0, count_yellow: 0, count_green: 0,
          percent_red: 0, percent_yellow: 0, percent_green: 0
        }
        return h if (size = ls.size).zero?

        h[:count_red] = ls.count { |l| l.color == RED }
        h[:count_yellow] = ls.count { |l| l.color == YELLOW }
        h[:count_green] = size - h[:count_red] - h[:count_yellow]

        h[:percent_red] = (100.0 * h[:count_red] / size).ceil
        h[:percent_yellow] = (100.0 * h[:count_yellow] / size).ceil
        h[:percent_green] = 100.0 - h[:percent_red] - h[:percent_yellow]

        h
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
