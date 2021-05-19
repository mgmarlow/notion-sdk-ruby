module Notion
  class Client
    include HTTParty
    include Endpoints

    base_uri "https://api.notion.com"
    headers "Content-Type": "application/json"
    
    def initialize(token:)
      self.class.headers({ Authorization: "Bearer #{token}" })
    end

    private

    def get(*args, &block)
      self.class.get(*args, &block)
    end

    def post(*args, &block)
      self.class.post(*args, &block)
    end

    def patch(*args, &block)
      self.class.patch(*args, &block)
    end

    def put(*args, &block)
      self.class.put(*args, &block)
    end

    def delete(*args, &block)
      self.class.delete(*args, &block)
    end
  end
end
