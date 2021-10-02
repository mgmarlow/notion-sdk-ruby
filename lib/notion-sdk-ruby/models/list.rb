module Notion
  class List
    attr_reader :data, :next_cursor, :has_more

    def initialize(response_body)
      @data = response_body["results"].map do |d|
        get_model(d["object"]).new(d)
      end

      @next_cursor = response_body["next_cursor"]
      @has_more = response_body["has_more"]
    end

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
