module Notion
  class Blocks
    include RequestClient

    def children
      Children.new
    end

    def retrieve(block_id)
      response = get("/v1/blocks/#{block_id}")
      Block.new(response.body)
    end

    def update(block_id, body)
      response = patch("/v1/blocks/#{block_id}", body.to_json)
      Block.new(response.body)
    end
  end

  class Children
    include RequestClient

    def list(block_id, query: {})
      response = get("/v1/blocks/#{block_id}/children", query: query)
      List.new(response.body)
    end

    def append(block_id, body)
      response = patch("/v1/blocks/#{block_id}/children", body.to_json)
      Block.new(response.body)
    end
  end
end
