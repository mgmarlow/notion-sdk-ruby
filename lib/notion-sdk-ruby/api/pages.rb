module Notion
  module Api
    module Pages
      def self.included(base)
        base.class_eval do
          def pages
            PagesMethods.new
          end
        end
      end
    end

    class PagesMethods
      include RequestClient

      # @param [String] id page_id
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
