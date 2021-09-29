RSpec.describe "search" do
  let(:access_token) { "foo-1234" }
  subject(:client) { Notion::Client.new(token: access_token) }

  let(:search_fixture) { load_fixture("search/200_search") }

  before do
    stub_request(:post, "https://api.notion.com/v1/search")
      .to_return(body: search_fixture)
  end

  describe "#search" do
    let(:body) do
      {
        query: "External tasks",
        sort: {
          direction: "ascending"
        }
      }
    end

    it "should call POST api.notion /search/" do
      client.search(body)

      expect(a_request(:post, "https://api.notion.com/v1/search")
        .with(body: body))
        .to have_been_made.once
    end

    it "should match fixture response" do
      expect(client.search(body).body).to eq(search_fixture)
    end
  end
end
