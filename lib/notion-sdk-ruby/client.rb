module Notion
  class Client
    # include Api::SearchMethods

    def initialize(token:, notion_version: "2025-09-03")
      @token = token
      @notion_version = notion_version
    end

    def request_client
      @request_client ||= RequestClient.new(token: @token, version: @notion_version)
    end

    # # @return [Notion::Api::DatabasesMethods]
    # def databases
    #   Api::DatabasesMethods.new
    # end

    # # @return [Notion::Api::UsersMethods]
    # def users
    #   Api::UsersMethods.new
    # end

    # # @return [Notion::Api::BlocksMethods]
    # def blocks
    #   Api::BlocksMethods.new
    # end

    def pages
      Api::Pages.new(request_client:)
    end
  end
end
