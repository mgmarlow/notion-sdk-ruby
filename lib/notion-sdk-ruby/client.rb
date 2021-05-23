module Notion
  class Client
    include Operations::Search

    def initialize(token:)
      Notion.api_token = token
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
