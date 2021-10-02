module Notion
  module Api
    class Databases
      include RequestClient

      # @param [String] database_id
      # @return [Notion::Database]
      def retrieve(id)
        response = get("/v1/databases/#{id}")
        Database.new(response.body)
      end

      # @deprecated
      # @return [Array<Notion::Database>]
      def list
        warn "DEPRECATED: client.databases.list is deprecated."
        response = get("/v1/databases")
        List.new(response.body)
      end

      # @param [String] database_id
      # @param [Hash] body
      # @return [Array<Notion::Database>]
      def query(id, body)
        response = post("/v1/databases/#{id}/query", body.to_json)
        List.new(response.body)
      end

      # @param [Hash] body
      # @return [Notion::Database]
      def create(body)
        response = post("/v1/databases", body.to_json)
        Database.new(response.body)
      end

      # @param [String] database_id
      # @param [Hash] body
      # @return [Notion::Database]
      def update(id, body)
        response = patch("/v1/databases/#{id}", body.to_json)
        Database.new(response.body)
      end
    end
  end
end
