module Notion
  class Client
    include HTTParty
    include Resources

    base_uri "https://api.notion.com"
    headers "Content-Type": "application/json"

    def initialize(token:)
      self.class.headers({Authorization: "Bearer #{token}"})
    end

    private

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
