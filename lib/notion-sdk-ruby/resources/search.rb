module Notion
  module Search
    def search(body)
      post("/v1/search", body: body.to_json)
    end
  end
end
