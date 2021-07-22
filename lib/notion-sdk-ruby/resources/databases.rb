module Notion
  class Databases
    def retrieve(id)
      RequestClient.active_client.get("/v1/databases/#{id}")
    end

    def list
      RequestClient.active_client.get("/v1/databases")
    end

    def query(id, body)
      RequestClient.active_client.post("/v1/databases/#{id}/query", body: body.to_json)
    end

    def create(body)
      RequestClient.active_client.post("/v1/databases", body: body.to_json)
    end
  end
end
