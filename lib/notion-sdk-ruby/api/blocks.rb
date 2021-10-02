module Notion
  module Api
    class Blocks
      include RequestClient

      def children
        Api::Children.new
      end

      # @param [String] block_id
      # @return [Notion::Block]
      def retrieve(block_id)
        response = get("/v1/blocks/#{block_id}")
        Block.new(response.body)
      end

      # @param [String] block_id
      # @param [Hash] body
      # @return [Notion::Block]
      def update(block_id, body)
        response = patch("/v1/blocks/#{block_id}", body.to_json)
        Block.new(response.body)
      end
    end

    class Children
      include RequestClient

      # @param [String] block_id
      # @param [Hash] query
      # @return [Array<Notion::Block>]
      def list(block_id, query = {})
        response = get("/v1/blocks/#{block_id}/children", query)
        List.new(response.body)
      end

      # @param [String] block_id
      # @param [Hash] body
      # @return [Array<Notion::Block>]
      def append(block_id, body)
        response = patch("/v1/blocks/#{block_id}/children", body.to_json)
        List.new(response.body)
      end
    end
  end
end
