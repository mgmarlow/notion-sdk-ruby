require "httparty"
require "notion/version"
require "notion/endpoints/blocks"
require "notion/endpoints/databases"
require "notion/endpoints/pages"
require "notion/endpoints/search"
require "notion/endpoints/users"
require "notion/endpoints"
require "notion/client"

module Notion
  class Error < StandardError; end
end
