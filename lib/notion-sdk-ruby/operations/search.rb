module Notion
  module Operations
    module Search
      include RequestClient

      def search(body)
        response = post("/v1/search", body.to_json)
        List.new(response.body)
      end
    end
  end
end
