# frozen_string_literal: true

module StoplightAdmin
  module Actions
    # This action locks light
    class Lock < Action
      # @param params [Hash] query parameters
      # @return [void]
      def call(params)
        light_names(params).each do |name|
          lights_repository.lock(name)
        end
      end

      private def light_names(params)
        Array(params[:names])
          .map { |l| CGI.unescape(l) }
      end
    end
  end
end
