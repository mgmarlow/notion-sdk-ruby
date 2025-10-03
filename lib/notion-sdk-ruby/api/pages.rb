module Notion
  module Api
    class Pages < Base
      # Retrieves a Page object using the ID specified.
      # https://developers.notion.com/reference/retrieve-a-page
      # @param [String] id page_id
      # @return [Notion::Page]
      def retrieve(id)
        resp = request_client.get("/v1/pages/#{id}")
        Page.new(resp)
      end

      # Creates a new page in the specified database or as a child of
      # an existing page.
      # https://developers.notion.com/reference/post-page
      # @param [Hash] body
      # @return [Notion::Page]
      def create(body)
        response = post("/v1/pages", body.to_json)
        Page.new(response.body)
      end

      # Updates page property values for the specified page.
      # https://developers.notion.com/reference/patch-page
      # @param [String] id page_id
      # @param [Hash] body
      # @return [Notion::Page]
      def update(id, body)
        response = patch("/v1/pages/#{id}", body.to_json)
        Page.new(response.body)
      end
    end
  end
end
