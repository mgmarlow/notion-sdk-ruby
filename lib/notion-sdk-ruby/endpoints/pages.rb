module Notion
  module Endpoints
    module Pages
      def get_page(id)
        self.class.get("/v1/pages/#{id}")
      end

      def create_page(body)
        self.class.post("/v1/pages", body: body.to_json)
      end

      def update_page(id, body)
        self.class.patch("/v1/pages/#{id}", body: body.to_json)
      end
    end
  end
end
