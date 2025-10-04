module Notion
  class Page
    ATTRIBUTES = %i[
      id created_time created_by last_edited_time
      last_edited_by archived in_trash icon cover properties
      parent url public_url
    ].freeze

    attr_reader(*ATTRIBUTES)
    attr_reader :object

    class << self
      def from_api(data)
        new(
          id: data["id"],
          object: data["object"],
          created_time: data["created_time"],
          created_by: data["created_by"] ? User::Partial.new(data["created_by"]["id"]) : nil,
          last_edited_time: data["last_edited_time"],
          last_edited_by: data["last_edited_by"] ? User::Partial.new(data["last_edited_by"]["id"]) : nil,
          archived: data["archived"],
          in_trash: data["in_trash"],
          icon: parse_icon(data["icon"]),
          cover: data["cover"] ? FileObject.from_api(data["cover"]) : nil,
          # TODO: properties
          properties: data["properties"],
          parent: data["parent"],
          url: data["url"],
          public_url: data["public_url"]
        )
      end

      private

      def parse_icon(icon_data)
        return nil unless icon_data

        if icon_data["type"] == "emoji"
          Emoji.new(icon_data["emoji"])
        else
          FileObject.from_api(icon_data)
        end
      end
    end

    def initialize(**attributes)
      @object = "page"
      ATTRIBUTES.each do |attr|
        instance_variable_set("@#{attr}", attributes[attr])
      end
    end
  end
end
