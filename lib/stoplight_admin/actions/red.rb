# frozen_string_literal: true

module StoplightAdmin
  module Actions
    # This action locks light with the specific name red
    class Red
      # @!attribute lights_repository
      #   @return [StoplightAdmin::LightsRepository]
      attr_reader :lights_repository
      private :lights_repository

      # @return lights_repository [StoplightAdmin::LightsRepository]
      def initialize(lights_repository:)
        @lights_repository = lights_repository
      end

      # @param params [Hash] query parameters
      # @return [void]
      def call(params)
        light_names(params).each do |name|
          lights_repository.lock(name, RED)
        end
      end

      private def light_names(params)
        Array(params[:names])
          .map  { |l| CGI.unescape(l) }
      end
    end
  end
end
