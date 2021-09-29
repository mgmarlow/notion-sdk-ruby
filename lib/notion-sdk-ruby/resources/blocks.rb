module Notion
  class Blocks
    include RequestClient

    def children
      Children.new
    end

    def retrieve(block_id)
      get("/v1/blocks/#{block_id}")
    end

    def update(block_id, body)
      patch("/v1/blocks/#{block_id}", body.to_json)
    end
  end

  class Children
    include RequestClient

    def list(block_id, query: {})
      get("/v1/blocks/#{block_id}/children", query: query)
    end

    def append(block_id, body)
      patch("/v1/blocks/#{block_id}/children", body.to_json)
    end
  end
end
