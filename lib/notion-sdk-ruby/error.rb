# Sourced from notion-sdk-js:
# https://github.com/makenotion/notion-sdk-js/blob/main/src/errors.ts
module Notion
  module Error
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

    class Error < StandardError; end

    class RequestTimeoutError < Error; end

    class HTTPResponseError < Error; end

    class APIResponseError < Error; end
  end
end
