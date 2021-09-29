module Notion
  module RequestClient
    def get(*args)
      handle_request(:get, *args)
    end

    def post(*args)
      handle_request(:post, *args)
    end

    def patch(*args)
      handle_request(:patch, *args)
    end

    def delete(*args)
      handle_request(:delete, *args)
    end

    private

    def handle_request(method, *args)
      faraday_client.public_send(method, *args)
    rescue Faraday::ClientError => error
      error_details = JSON.parse(error.response[:body])
      raise ErrorFactory.create(error_details)
    rescue JSON::ParserError => error
      raise NotionError.new(error.message)
    end

    def faraday_client
      @faraday_client ||= Faraday.new(
        url: "https://api.notion.com",
        headers: {
          "Content-Type" => "application/json",
          "Notion-Version" => Notion.config.notion_version,
          "Authorization" => "Bearer #{Notion.config.api_token}"
        }
      ) do |f|
        f.request :json
        f.response :json
        f.use Faraday::Response::RaiseError
      end
    end
  end
end
