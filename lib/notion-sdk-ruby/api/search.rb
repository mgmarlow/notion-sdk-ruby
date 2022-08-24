module Notion
  module Api
    module SearchMethods
      include RequestClient

      # Searches all original pages, databases, and child pages/databases
      # that are shared with the integration.
      # https://developers.notion.com/reference/post-search
      # @param [Hash] body
      # @return [Notion::List<OpenStruct>]
      def search(body)
        response = post("/v1/search", body.to_json)
        List.new(response.body)
      end
    end
  end
end
