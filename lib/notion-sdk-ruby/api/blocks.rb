module Notion
  module Api
    class BlocksMethods
      include RequestClient

      # @return [Notion::Api::BlocksChildrenMethods]
      def children
        BlocksChildrenMethods.new
      end

      # Retrieves a Block object using the ID specified.
      # https://developers.notion.com/reference/retrieve-a-block
      # @param [String] id block_id
      # @return [Notion::Block]
      def retrieve(id)
        response = get("/v1/blocks/#{id}")
        Block.new(response.body)
      end

      # Updates the content for the specified block_id based on the block type.
      # https://developers.notion.com/reference/update-a-block
      # @param [String] id block_id
      # @param [Hash] body
      # @return [Notion::Block]
      def update(id, body)
        response = patch("/v1/blocks/#{id}", body.to_json)
        Block.new(response.body)
      end
    end

    class BlocksChildrenMethods
      include RequestClient

      # Returns a paginated array of child block objects contained in the block
      # using the ID specified.
      # https://developers.notion.com/reference/get-block-children
      # @param [String] id block_id
      # @param [Hash] query
      # @return [Notion::List<Notion::Block>]
      def list(id, query = {})
        response = get("/v1/blocks/#{id}/children", query)
        List.new(response.body)
      end

      # Creates and appends new children blocks to the parent block_id specified.
      # https://developers.notion.com/reference/patch-block-children
      # @param [String] id block_id
      # @param [Hash] body
      # @return [Notion::List<Notion::Block>]
      def append(id, body)
        response = patch("/v1/blocks/#{id}/children", body.to_json)
        List.new(response.body)
      end
    end
  end
end
