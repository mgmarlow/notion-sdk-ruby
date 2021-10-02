module Notion
  module Api
    module Search
      def self.included(base)
        base.class_eval do
          include SearchMethods
        end
      end
    end

    module SearchMethods
      include RequestClient

      # @param [Hash] body
      # @return [Array]
      def search(body)
        response = post("/v1/search", body.to_json)
        List.new(response.body)
      end
    end
  end
end
