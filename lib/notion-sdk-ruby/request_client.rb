module Notion
  class RequestClient
    def self.active_client
      Faraday.new(
        url: "https://api.notion.com",
        headers: {
          "Content-Type" => "application/json",
          "Notion-Version" => Notion.config.notion_version,
          "Authorization" => "Bearer #{Notion.config.api_token}"
        }
      )
    end
  end
end
