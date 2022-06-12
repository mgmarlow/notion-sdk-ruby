module Notion
  class Client
    include Api::SearchMethods

    def initialize(token:, notion_version: "2022-02-22")
      Notion.api_token = token
      Notion.notion_version = notion_version
    end

    # @return [Notion::Api::DatabasesMethods]
    def databases
      Api::DatabasesMethods.new
    end

    # @return [Notion::Api::UsersMethods]
    def users
      Api::UsersMethods.new
    end

    # @return [Notion::Api::BlocksMethods]
    def blocks
      Api::BlocksMethods.new
    end

    # @return [Notion::Api::PagesMethods]
    def pages
      Api::PagesMethods.new
    end
  end
end
