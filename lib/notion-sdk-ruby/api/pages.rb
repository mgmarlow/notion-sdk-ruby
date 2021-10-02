module Notion
  module Api
    class Pages
      include RequestClient

      # @param [String] page_id
      # @return [Notion::Page]
      def retrieve(id)
        response = get("/v1/pages/#{id}")
        Page.new(response.body)
      end

      # @param [Hash] body
      # @return [Notion::Page]
      def create(body)
        response = post("/v1/pages", body.to_json)
        Page.new(response.body)
      end

      # @param [String] page_id
      # @param [Hash] body
      # @return [Notion::Page]
      def update(id, body)
        response = patch("/v1/pages/#{id}", body.to_json)
        Page.new(response.body)
      end
    end
  end
end
