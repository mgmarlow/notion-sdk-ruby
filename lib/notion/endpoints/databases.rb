module Notion
  module Endpoints
    module Databases
      def get_database(id)
        self.class.get("/v1/databases/#{id}")
      end

      def get_databases
        self.class.get("/v1/databases")
      end

      def query_database(id, body)
        self.class.post("/v1/databases/#{id}/query", body: body.to_json)
      end
    end
  end
end
