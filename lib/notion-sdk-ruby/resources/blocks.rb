module Notion
  class Blocks
    def children
      Children.new
    end
  end

  class Children
    def list(block_id, query: {})
      RequestClient.active_client.get("/v1/blocks/#{block_id}/children", query: query)
    end

    def append(block_id, body)
      RequestClient.active_client.patch("/v1/blocks/#{block_id}/children", body: body.to_json)
    end
  end
end
