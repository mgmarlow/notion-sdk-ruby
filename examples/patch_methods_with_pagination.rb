require "dotenv/load"
require "notion-sdk-ruby"

module Notion::Api
  module Exhaustiveness
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def exhaustively(name)
        define_method("#{name}_all") do |*args, &block|
          items = []
          cursor = nil

          loop do
            if args.last.is_a?(Hash)
              args.last.merge(start_cursor: cursor).compact
            else
              args << { start_cursor: cursor }.compact
            end
            list = method(name).call(*args)

            items += list.data.tap { |d| d.each { block.call(_1) } if block }
            cursor = list.next_cursor

            break unless list.has_more
          end

          items
        end
      end
    end
  end

  class BlocksChildrenMethods
    include Exhaustiveness

    # @!method list_all(id, query = {})
    #   @param [String] id block_id
    #   @param [Hash] query
    #   @return [Array<Notion::Block>]
    exhaustively :list
  end

  class DatabasesMethods
    include Exhaustiveness

    # @!method query_all(id, body)
    #   @param [String] id database_id
    #   @param [Hash] body
    #   @return [Array<Notion::Database>]
    exhaustively :query
  end

  module SearchMethods
    include Exhaustiveness

    # @!method search_all(body)
    #   @param [Hash] body
    #   @return [Array]
    exhaustively :search
  end

  # # Not applicable since `start_cursor` is not supported by now
  # class UsersMethods
  #   include Exhaustiveness
  #   exhaustively :list
  # end
end

Notion::Client.new(token: ENV['NOTION_API_SECRET'])
  .databases.query_all('YOUR_DATABASE_ID', {}) { pp _ }
