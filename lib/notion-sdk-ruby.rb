require "faraday"
require "faraday_middleware"
require "forwardable"
require "ostruct"

require "notion-sdk-ruby/version"
require "notion-sdk-ruby/config"
require "notion-sdk-ruby/request_client"
require "notion-sdk-ruby/resources/blocks"
require "notion-sdk-ruby/resources/databases"
require "notion-sdk-ruby/resources/pages"
require "notion-sdk-ruby/resources/users"
require "notion-sdk-ruby/operations/search"
require "notion-sdk-ruby/error"
require "notion-sdk-ruby/client"
require "notion-sdk-ruby/models/user"
require "notion-sdk-ruby/models/list"
require "notion-sdk-ruby/models/block"
require "notion-sdk-ruby/models/database"
require "notion-sdk-ruby/models/page"

module Notion
  @config = Config.new

  class << self
    extend Forwardable

    attr_reader :config

    def_delegators :@config, :api_token, :api_token=
    def_delegators :@config, :notion_version, :notion_version=
  end
end
