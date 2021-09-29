module Notion
  class Client
    include RequestClient
    include Operations::Search

    def initialize(token:, notion_version: "2021-08-16")
      Notion.api_token = token
      Notion.notion_version = notion_version
    end

    def blocks
      Blocks.new
    end

    def databases
      Databases.new
    end

    def pages
      Pages.new
    end

    def users
      Users.new
    end
  end
end
