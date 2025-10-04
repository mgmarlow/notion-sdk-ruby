module Notion
  module Api
    class Pages < Base
      def retrieve(id)
        resp = request_client.get("/v1/pages/#{id}")
        Page.from_api(resp)
      end

      def create(body)
        resp = request_client.post("/v1/pages", body)
        Page.from_api(resp)
      end
    end
  end
end
