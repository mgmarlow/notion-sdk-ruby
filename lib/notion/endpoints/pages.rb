module Notion
  module Endpoints
    module Pages
      def get_page(id)
        self.class.get("/v1/pages/#{id}")
      end

      def create_page(body)
        self.class.post("/v1/pages", body: body)
      end

      def update_page(id, body)
        self.class.patch("/v1/pages/#{id}", body: body)
      end
    end
  end
end
