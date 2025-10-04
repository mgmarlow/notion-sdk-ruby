module Notion
  class List
    ATTRIBUTES = %i[results next_cursor has_more
      type page_or_data_source request_id]

    attr_reader(*ATTRIBUTES)
    attr_reader :object

    class << self
      def from_api(data)
        new(
          results: parse_results(data),
          next_cursor: data["next_cursor"],
          has_more: data["has_more"],
          type: data["type"],
          page_or_data_source: data["page_or_data_source"],
          request_id: data["request_id"]
        )
      end

      private

      def parse_results(data)
        data["results"].map do |d|
          case d["object"]
          when "page"
            Page.from_api(d)
          # TODO: data_sources
          else
            raise "not yet implemented"
          end
        end
      end
    end

    def initialize(**attributes)
      @object = "list"
      ATTRIBUTES.each do |attr|
        instance_variable_set("@#{attr}", attributes[attr])
      end
    end
  end
end
