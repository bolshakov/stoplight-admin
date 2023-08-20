# frozen_string_literal: true

module StoplightAdmin
  module Actions
    # This action unlocks light
    class Unlock < Action
      # @param params [Hash] query parameters
      # @return [void]
      def call(params)
        light_names(params).each do |name|
          lights_repository.unlock(name)
        end
      end

      private def light_names(params)
        Array(params[:names])
          .map  { |l| CGI.unescape(l) }
      end
    end
  end
end
