module Notion
  module Api
    module Databases
      def self.included(base)
        base.class_eval do
          def databases
            DatabasesMethods.new
          end
        end
      end
    end

    class DatabasesMethods
      include RequestClient

      # @param [String] id database_id
      # @return [Notion::Database]
      def retrieve(id)
        response = get("/v1/databases/#{id}")
        Database.new(response.body)
      end

      # @param [String] id database_id
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

      # @param [String] id database_id
      # @param [Hash] body
      # @return [Notion::Database]
      def update(id, body)
        response = patch("/v1/databases/#{id}", body.to_json)
        Database.new(response.body)
      end
    end
  end
end
