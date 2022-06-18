require "dotenv/load"
require "notion-sdk-ruby"

def list_users
  client = Notion::Client.new(token: ENV["NOTION_API_KEY"])
  client.users.retrieve("foo-bar")
rescue Notion::APIResponseError => e
  if e.code === "validation_error"
    puts "API Error: Invalid ID specified!", e.message
  end
end

list_users
