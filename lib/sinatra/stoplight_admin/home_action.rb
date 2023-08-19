# frozen_string_literal: true

require 'sinatra/stoplight_admin/lights_repository'

module Sinatra
  module StoplightAdmin
    class HomeAction
      # @!attribute lights_repository
      #   @return [Sinatra::StoplightAdmin::LightsRepository]
      attr_reader :lights_repository
      private :lights_repository

      # @!attribute lights_stats
      #   @return [Sinatra::StoplightAdmin::LightsStats]
      attr_reader :lights_stats
      private :lights_stats

      # @return lights_repository [Sinatra::StoplightAdmin::LightsRepository]
      # @param lights_stats [Class<Sinatra::StoplightAdmin::LightsStats>]
      def initialize(lights_repository:, lights_stats:)
        @lights_repository = lights_repository
        @lights_stats = lights_stats
      end

      # @return [(Sinatra::StoplightAdmin::LightsRepository::Light)]
      def call
        lights = lights_repository.all
        stats = lights_stats.call(lights)
        [lights, stats]
      end
    end
  end
end
