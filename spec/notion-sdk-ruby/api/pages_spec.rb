RSpec.describe "pages", :vcr do
  let(:access_token) { ENV["NOTION_API_KEY"] }

  subject(:client) { Notion::Client.new(token: access_token) }

  let(:page_id) { "783fdf36731349fba4cb6640a2d87e58" }
  let(:database_id) { "0b99d13693254b809dfc617b1061c399" }

  describe "pages#retrieve" do
    it "should return an instance of Notion::Page" do
      result = client.pages.retrieve(page_id)

      aggregate_failures do
        expect(a_request(:get, "https://api.notion.com/v1/pages/#{page_id}"))
          .to have_been_made.once
        expect(result).to be_an_instance_of(Notion::Page)
      end
    end

    describe "when the page id is not found" do
      let(:page_id) { "111aaa22222222bbb3cc4444d5e66f77" }

      it "should raise Notion::APIResponseError" do
        expect {
          client.pages.retrieve(page_id)
        }.to raise_error(Notion::APIResponseError)
      end
    end
  end

  describe "pages#create" do
    let(:body) do
      {
        parent: {
          database_id: database_id
        },
        properties: {}
      }
    end

    it "should return an instance of Notion::Page" do
      result = client.pages.create(body)

      aggregate_failures do
        expect(a_request(:post, "https://api.notion.com/v1/pages")
          .with(body: body))
          .to have_been_made.once
        expect(result).to be_an_instance_of(Notion::Page)
      end
    end
  end

  describe "pages#update" do
    let(:body) do
      {
        properties: {
          "In stock": {checkbox: true}
        }
      }
    end

    it "should return an instance of Notion::Page" do
      result = client.pages.update(page_id, body)

      aggregate_failures do
        expect(a_request(:patch, "https://api.notion.com/v1/pages/#{page_id}")
          .with(body: body))
          .to have_been_made.once
        expect(result).to be_an_instance_of(Notion::Page)
      end
    end
  end
end
