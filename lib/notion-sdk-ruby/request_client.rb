module Notion
  class RequestClient
    BASE_URL = "https://api.notion.com"

    def initialize(token:, version:)
      @token = token
      @notion_version = version
    end

    def get(path, params = {})
      handle_request(:get, path, params)
    end

    def post(path, body = {})
      handle_request(:post, path, body)
    end

    def patch(path, body = {})
      handle_request(:patch, path, body)
    end

    def delete(path, body = {})
      handle_request(:delete, path, body)
    end

    private

    def handle_request(method, path, data = {})
      uri = URI.join(BASE_URL, path)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = build_request(method, uri, data)

      response = http.request(request)

      handle_response(response)
    rescue JSON::ParserError => error
      raise NotionError.new(error.message)
    end

    def build_request(method, uri, data)
      case method
      when :get
        uri.query = URI.encode_www_form(data) unless data.empty?
        request = Net::HTTP::Get.new(uri)
      when :post
        request = Net::HTTP::Post.new(uri)
        request.body = data.to_json unless data.empty?
      when :patch
        request = Net::HTTP::Patch.new(uri)
        request.body = data.to_json unless data.empty?
      when :delete
        request = Net::HTTP::Delete.new(uri)
        request.body = data.to_json unless data.empty?
      end

      request['Content-Type'] = 'application/json'
      request['Notion-Version'] = @notion_version
      request['Authorization'] = "Bearer #{@token}"

      request
    end

    def handle_response(response)
      case response.code.to_i
      when 200..299
        JSON.parse(response.body)
      when 400..499, 500..599
        error_details = JSON.parse(response.body)
        raise ErrorFactory.create(error_details)
      else
        raise NotionError.new("Unexpected response code: #{response.code}")
      end
    end
  end
end
