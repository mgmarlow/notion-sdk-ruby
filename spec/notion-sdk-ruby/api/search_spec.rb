RSpec.describe "search", :vcr do
  let(:access_token) { ENV["NOTION_API_KEY"] }

  subject(:client) { Notion::Client.new(token: access_token) }

  describe "#search" do
    let(:body) do
      {
        query: "External tasks",
        sort: {
          direction: "ascending",
          timestamp: "last_edited_time"
        }
      }
    end

    it "should call POST api.notion /search/" do
      client.search(body)

      expect(a_request(:post, "https://api.notion.com/v1/search")
        .with(body: body))
        .to have_been_made.once
    end
  end
end
