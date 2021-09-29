module Notion
  class Databases
    include RequestClient

    def retrieve(id)
      response = get("/v1/databases/#{id}")
      Database.new(response.body)
    end

    # DEPRECATED
    def list
      warn "DEPRECATED: client.databases.list is deprecated."
      response = get("/v1/databases")
      List.new(response.body)
    end

    def query(id, body)
      response = post("/v1/databases/#{id}/query", body.to_json)
      List.new(response.body)
    end

    def create(body)
      response = post("/v1/databases", body.to_json)
      Database.new(response.body)
    end

    def update(id, body)
      response = patch("/v1/databases/#{id}", body.to_json)
      Database.new(response.body)
    end
  end
end
