module Notion
  class Client
    include Endpoints
    include HTTParty
    base_uri "https://api.notion.com"

    def initialize(token:)
      self.class.headers({ Authorization: "Bearer #{token}" })
    end
  end
end
