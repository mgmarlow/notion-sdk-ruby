module Notion
  # The List object is an intermediate object that helps with pagination.
  #
  # https://developers.notion.com/reference/pagination
  class List
    # An array of endpoint-dependent objects
    # @return [Array<Notion::User>]
    # @return [Array<Notion::Database>]
    # @return [Array<Notion::Page>]
    # @return [Array<Notion::Block>]
    attr_reader :data

    # Used to retrieve the next page of results by passing the value as the
    # start_cursor parameter to the same endpoint.
    # @return [nil] if has_more is true.
    # @return [string] if has_more is false.
    attr_reader :next_cursor

    # When the response includes the end of the list, false. Otherwise, true.
    # @return [boolean]
    attr_reader :has_more

    def initialize(response_body)
      @data = response_body["results"].map do |d|
        get_model(d["object"]).new(d)
      end

      @next_cursor = response_body["next_cursor"]
      @has_more = response_body["has_more"]
    end

    private

    def get_model(object_name)
      case object_name
      when "block"
        Block
      when "database"
        Database
      when "page"
        Page
      when "user"
        User
      else
        raise NotionError.new("unimplemented object type")
      end
    end
  end
end
