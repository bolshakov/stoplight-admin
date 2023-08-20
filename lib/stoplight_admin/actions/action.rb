# frozen_string_literal: true

module StoplightAdmin
  module Actions
    # @abstract
    class Action
      # @!attribute lights_repository
      #   @return [StoplightAdmin::LightsRepository]
      attr_reader :lights_repository
      private :lights_repository

      # @return lights_repository [StoplightAdmin::LightsRepository]
      def initialize(lights_repository:)
        @lights_repository = lights_repository
      end

      def call(params)
        raise NotImplementedError
      end
    end
  end
end
