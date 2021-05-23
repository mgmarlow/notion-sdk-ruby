module Notion
  module Blocks
    def get_block_children(id, params: {})
      get("/v1/blocks/#{id}/children", query: params)
    end

    def append_block_children(id, body)
      patch("/v1/blocks/#{id}/children", body: body.to_json)
    end
  end
end
