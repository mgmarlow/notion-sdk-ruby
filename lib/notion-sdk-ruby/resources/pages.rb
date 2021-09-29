module Notion
  class Pages
    include RequestClient

    def retrieve(id)
      get("/v1/pages/#{id}")
    end

    def create(body)
      post("/v1/pages", body.to_json)
    end

    def update(id, body)
      patch("/v1/pages/#{id}", body.to_json)
    end
  end
end
