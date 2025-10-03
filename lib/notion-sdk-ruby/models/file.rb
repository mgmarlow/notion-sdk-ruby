module Notion
  class FileObject
    def self.create(json)
      case json["type"]
      when "file"
        File.new(url: json["file"]["url"], expiry_time: json["file"]["expiry_time"])
      when "file_upload"
        FileUpload.new(id: json["file_upload"]["id"])
      when "external"
        FileExternal.new(url: json["external"]["url"])
      end
    end
  end

  class File
    attr_reader :url, :expiry_time, :type

    def initialize(url:, expiry_time:)
      @url = url
      @expiry_time = expiry_time
      @type = "file_upload"
    end
  end

  class FileUpload
    attr_reader :id, :type

    def initialize(id:)
      @id = id
      @type = "file_upload"
    end
  end

  class FileExternal
    attr_reader :url, :type

    def initialize(url:)
      @url = url
      @type = "external"
    end
  end
end
