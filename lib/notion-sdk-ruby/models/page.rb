module Notion
  class Page
    ATTRIBUTES = %i[
      id object created_time created_by last_edited_time
      last_edited_by archived in_trash icon cover properties
      parent url public_url
    ].freeze

    attr_reader(*ATTRIBUTES)

    def initialize(data)
      ATTRIBUTES.each do |attr|
        # TODO: properties
        case attr
        when :created_by, :last_edited_by
          instance_variable_set("@#{attr}", User::Partial.new(data[attr.to_s]["id"]))
        when :cover
          @cover = data["cover"] ? FileObject.create(data["cover"]) : nil
        when :icon
          @icon = nil unless data["icon"]

          @icon = if data["icon"] == "emoji"
            Emoji.new(data["icon"]["emoji"])
          else
            FileObject.create(data["icon"])
          end
        else
          instance_variable_set("@#{attr}", data[attr.to_s])
        end
      end
    end
  end
end
