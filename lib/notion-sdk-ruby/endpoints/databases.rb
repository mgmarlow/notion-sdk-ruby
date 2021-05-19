module Notion
  module Endpoints
    module Databases
      def get_database(id)
        get("/v1/databases/#{id}")
      end

      def get_databases
        get("/v1/databases")
      end

      def query_database(id, body)
        post("/v1/databases/#{id}/query", body: body.to_json)
      end
    end
  end
end
