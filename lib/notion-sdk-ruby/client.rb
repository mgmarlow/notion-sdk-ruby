module Notion
  class Client
    include RequestClient
    include Api::Search

    def initialize(token:, notion_version: "2021-08-16")
      Notion.api_token = token
      Notion.notion_version = notion_version
    end

    def blocks
      Api::Blocks.new
    end

    def databases
      Api::Databases.new
    end

    def pages
      Api::Pages.new
    end

    def users
      Api::Users.new
    end
  end
end
