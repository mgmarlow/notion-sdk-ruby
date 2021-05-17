module Notion
  module Endpoints
    module Search
      def search(body)
        self.class.post("/v1/search", body: body.to_json)
      end
    end
  end
end
