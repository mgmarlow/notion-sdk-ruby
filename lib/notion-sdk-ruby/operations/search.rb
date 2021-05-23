module Notion
  module Operations
    module Search
      def search(body)
        RequestClient.active_client.post("/v1/search", body: body.to_json)
      end
    end
  end
end
