# https://developers.notion.com/reference/status-codes
module Notion
  API_ERROR_CODE = {
    invalid_json: "invalid_json",
    invalid_request_url: "invalid_request_url",
    invalid_request: "invalid_request",
    invalid_grant: "invalid_grant",
    validation_error: "validation_error",
    missing_version: "missing_version",
    unauthorized: "unauthorized",
    restricted_resource: "restricted_resource",
    object_not_found: "object_not_found",
    conflict_error: "conflict_error",
    rate_limited: "rate_limited",
    internal_server_error: "internal_server_error",
    bad_gateway: "bad_gateway",
    service_unavailable: "service_unavailable",
    database_connection_unavailable: "database_connection_unavailable",
    gateway_timeout: "gateway_timeout"
  }

  class ErrorFactory
    def self.create(error = {})
      return NotionError.new("Unknown error.") if error["message"].nil?

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
