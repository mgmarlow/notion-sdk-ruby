module Notion
  class Pages
    def retrieve(id)
      RequestClient.active_client.get("/v1/pages/#{id}")
    end

    def create(body)
      RequestClient.active_client.post("/v1/pages", body: body.to_json)
    end

    def update(id, body)
      RequestClient.active_client.patch("/v1/pages/#{id}", body: body.to_json)
    end
  end
end
