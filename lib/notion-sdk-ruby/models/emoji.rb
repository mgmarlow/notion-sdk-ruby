module Notion
  class Emoji
    attr_reader :type, :emoji

    def initialize(emoji)
      @type = "emoji"
      @emoji = emoji
    end
  end
end
