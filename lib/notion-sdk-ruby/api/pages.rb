module Notion
  module Api
    class Pages < Base
      def retrieve(id)
        resp = request_client.get("/v1/pages/#{id}")
        Page.from_api(resp)
      end
    end
  end
end
