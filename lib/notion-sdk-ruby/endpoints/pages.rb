module Notion
  module Endpoints
    module Pages
      def get_page(id)
        get("/v1/pages/#{id}")
      end

      def create_page(body)
        post("/v1/pages", body: body.to_json)
      end

      def update_page(id, body)
        patch("/v1/pages/#{id}", body: body.to_json)
      end
    end
  end
end
