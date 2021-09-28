module Notion
  class Databases
    def retrieve(id)
      RequestClient.active_client.get("/v1/databases/#{id}")
    end

    # DEPRECATED
    def list
      warn "DEPRECATED: client.databases.list is deprecated."
      RequestClient.active_client.get("/v1/databases")
    end

    def query(id, body)
      RequestClient.active_client.post("/v1/databases/#{id}/query", body: body.to_json)
    end

    def create(body)
      RequestClient.active_client.post("/v1/databases", body: body.to_json)
    end

    def update(id, body)
      RequestClient.active_client.patch("/v1/databases/#{id}", body: body.to_json)
    end
  end
end
