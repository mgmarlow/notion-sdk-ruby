module Notion
  module Operations
    module Search
      include RequestClient

      def search(body)
        post("/v1/search", body.to_json)
      end
    end
  end
end
