module Notion
  module Api
    module Blocks
      def self.included(base)
        base.class_eval do
          def blocks
            BlocksMethods.new
          end
        end
      end
    end

    class BlocksMethods
      include RequestClient

      def children
        BlocksChildrenMethods.new
      end

      # @param [String] id block_id
      # @return [Notion::Block]
      def retrieve(id)
        response = get("/v1/blocks/#{id}")
        Block.new(response.body)
      end

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

      # @param [String] id block_id
      # @param [Hash] query
      # @return [Array<Notion::Block>]
      def list(id, query = {})
        response = get("/v1/blocks/#{id}/children", query)
        List.new(response.body)
      end

      # @param [String] id block_id
      # @param [Hash] body
      # @return [Array<Notion::Block>]
      def append(id, body)
        response = patch("/v1/blocks/#{id}/children", body.to_json)
        List.new(response.body)
      end
    end
  end
end
