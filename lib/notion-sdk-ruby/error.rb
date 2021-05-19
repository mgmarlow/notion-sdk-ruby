# Sourced from notion-sdk-js:
# https://github.com/makenotion/notion-sdk-js/blob/main/src/errors.ts
module Notion
  API_ERROR_CODE = {
    unauthorized: "unauthorized",
    restricted_resource: "restricted_resource",
    object_not_found: "object_not_found",
    rate_limited: "rate_limited",
    invalid_json: "invalid_json",
    invalid_request_url: "invalid_request_url",
    invalid_request: "invalid_request",
    validation_error: "validation_error",
    conflict_error: "conflict_error",
    internal_server_error: "internal_server_error",
    service_unavailable: "service_unavailable"
  }

  class ErrorFactory
    def self.create(error = nil)
      return NotionError.new("Unknown error.") if error.nil? || error["message"].nil?

      if API_ERROR_CODE.value?(error["code"])
        APIResponseError.new(error["message"], body: error)
      elsif error["request"] && error["response"] && error["timings"]
        HTTPResponseError.new(error["message"], body: error)
      elsif error["request"] && error["timings"]
        RequestTimeoutError.new(error["message"], body: error)
      else
        NotionError.new(error["message"])
      end
    end
  end

  class NotionError < StandardError
    attr_reader :message, :body

    def initialize(message = nil, body: nil)
      @message = message
      @body = body
    end
  end

  class RequestTimeoutError < NotionError; end

  class HTTPResponseError < NotionError; end

  class APIResponseError < NotionError
    def code
      body["code"]
    end
  end
end
