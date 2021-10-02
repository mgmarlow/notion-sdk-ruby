module Notion
  class Client
    include Api::Search
    include Api::Pages
    include Api::Blocks
    include Api::Databases
    include Api::Users

    def initialize(token:, notion_version: "2021-08-16")
      Notion.api_token = token
      Notion.notion_version = notion_version
    end
  end
end
