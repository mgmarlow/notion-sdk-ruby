module Notion
  class Client
    def initialize(token:, notion_version: "2025-09-03")
      @token = token
      @notion_version = notion_version
    end

    def request_client
      @request_client ||= RequestClient.new(token: @token, version: @notion_version)
    end

    def pages
      Api::Pages.new(request_client:)
    end

    def search(query, sort: nil, filter: nil, start_cursor: nil, page_size: 100)
      resp = request_client.post("/v1/search", {
        query:,
        sort:,
        filter:,
        start_cursor:,
        page_size:
      }.compact)
      List.from_api(resp)
    end
  end
end
