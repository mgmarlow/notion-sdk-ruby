module Notion
  module Api
    class DatabasesMethods
      include RequestClient

      # Retrieves a Database object using the ID specified.
      # https://developers.notion.com/reference/retrieve-a-database
      # @param [String] id database_id
      # @return [Notion::Database]
      def retrieve(id)
        response = get("/v1/databases/#{id}")
        Database.new(response.body)
      end

      # Gets a list of Pages contained in the database, filtered and ordered according
      # to the filter conditions and sort criteria provided in the request.
      # https://developers.notion.com/reference/post-database-query
      # @param [String] id database_id
      # @param [Hash] body
      # @return [Notion::List<Notion::Page>]
      def query(id, body)
        response = post("/v1/databases/#{id}/query", body.to_json)
        List.new(response.body)
      end

      # Creates a database as a subpage in the specified parent page, with the
      # specified properties schema.
      # https://developers.notion.com/reference/create-a-database
      # @param [Hash] body
      # @return [Notion::Database]
      def create(body)
        response = post("/v1/databases", body.to_json)
        Database.new(response.body)
      end

      # Updates an existing database as specified by the parameters.
      # https://developers.notion.com/reference/update-a-database
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
