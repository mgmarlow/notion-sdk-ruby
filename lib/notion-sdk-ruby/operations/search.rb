module Notion
  module Operations
    module Search
      # @param [Hash] body
      # @return [Array]
      def search(body)
        response = post("/v1/search", body.to_json)
        List.new(response.body)
      end
    end
  end
end
