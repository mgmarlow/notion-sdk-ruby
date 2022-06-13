require "dotenv/load"
require "notion-sdk-ruby"

class ExhaustiveSearch
  attr_reader :data

  def initialize(query)
    @query = query
    @has_more = true
    @next_cursor = nil
  end

  def search
    data = []

    until done_searching?
      result = notion_client.search(search_params)
      data << result.data
      @has_more = result.has_more
      @next_cursor = result.next_cursor
    end

    data.flatten
  end

  private

  def done_searching?
    !@has_more
  end

  def search_params
    @query
      .merge({start_cursor: @next_cursor})
      .compact
  end

  def notion_client
    @notion_client ||= Notion::Client.new(token: ENV["NOTION_API_KEY"])
  end
end

data = ExhaustiveSearch.new({
  query: "grocery",
  sort: {
    direction: "ascending",
    timestamp: "last_edited_time"
  },
  page_size: 3
}).search

puts data
