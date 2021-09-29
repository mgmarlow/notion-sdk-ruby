module Notion
  class Databases
    include RequestClient

    def retrieve(id)
      get("/v1/databases/#{id}")
    end

    # DEPRECATED
    def list
      warn "DEPRECATED: client.databases.list is deprecated."
      get("/v1/databases")
    end

    def query(id, body)
      post("/v1/databases/#{id}/query", body.to_json)
    end

    def create(body)
      post("/v1/databases", body.to_json)
    end

    def update(id, body)
      patch("/v1/databases/#{id}", body.to_json)
    end
  end
end
