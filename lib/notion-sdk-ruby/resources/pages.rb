module Notion
  class Pages
    include RequestClient

    def retrieve(id)
      response = get("/v1/pages/#{id}")
      Page.new(response.body)
    end

    def create(body)
      response = post("/v1/pages", body.to_json)
      Page.new(response.body)
    end

    def update(id, body)
      response = patch("/v1/pages/#{id}", body.to_json)
      Page.new(response.body)
    end
  end
end
