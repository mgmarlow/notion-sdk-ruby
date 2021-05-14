module Notion
  module Endpoints
    module Blocks
      def get_block_children(id, params: {})
        self.class.get("/v1/blocks/#{id}/children", query: params)
      end

      def append_block_children(id, body)
        self.class.patch("/v1/blocks/#{id}/children", body: body)
      end
    end
  end
end
