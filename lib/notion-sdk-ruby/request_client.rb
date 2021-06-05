module Notion
  class RequestClient
    include HTTParty

    base_uri "https://api.notion.com"
    headers "Content-Type": "application/json"
    headers "Notion-Version": "2021-05-13"

    def self.active_client
      RequestClient.new(Notion.config)
    end

    def initialize(config)
      self.class.headers Authorization: "Bearer #{config.api_token}"
    end

    def get(*args, &block)
      response = self.class.get(*args, &block)
      raise_on_failure(response)
    end

    def post(*args, &block)
      response = self.class.post(*args, &block)
      raise_on_failure(response)
    end

    def patch(*args, &block)
      response = self.class.patch(*args, &block)
      raise_on_failure(response)
    end

    def put(*args, &block)
      response = self.class.put(*args, &block)
      raise_on_failure(response)
    end

    def delete(*args, &block)
      response = self.class.delete(*args, &block)
      raise_on_failure(response)
    end

    def raise_on_failure(response)
      if response.success?
        response
      else
        raise ErrorFactory.create(response)
      end
    end
  end
end
