RSpec.describe "pages" do
  let(:access_token) { "foo-1234" }
  subject(:client) { Notion::Client.new(token: access_token) }

  let(:page_id) { "foo-page-1234" }
  let(:create_page_fixture) { load_fixture("pages/200_create_page") }
  let(:get_page_fixture) { load_fixture("pages/200_get_page") }
  let(:update_page_fixture) { load_fixture("pages/200_update_page") }

  before do
    stub_request(:get, "https://api.notion.com/v1/pages/#{page_id}")
      .to_return(body: get_page_fixture)

    stub_request(:post, "https://api.notion.com/v1/pages")
      .to_return(body: create_page_fixture)

    stub_request(:patch, "https://api.notion.com/v1/pages/#{page_id}")
      .to_return(body: update_page_fixture)
  end

  describe "#get_page" do
    it "should call GET api.notion /pages/{id}" do
      client.get_page(page_id)

      expect(a_request(:get, "https://api.notion.com/v1/pages/#{page_id}"))
        .to have_been_made.once
    end

    it "should match fixture response" do
      expect(client.get_page(page_id).parsed_response).to eq(get_page_fixture)
    end
  end

  describe "#create_page" do
    let(:body) do
      {
        parent: {
          database_id: "abcd-database-1234"
        },
        properties: {}
      }
    end

    it "should call POST api.notion /pages/" do
      client.create_page(body)

      expect(a_request(:post, "https://api.notion.com/v1/pages")
        .with(body: body))
        .to have_been_made.once
    end

    it "should match fixture response" do
      expect(client.create_page(body).parsed_response).to eq(create_page_fixture)
    end
  end

  describe "#update_page" do
    let(:body) do
      {
        properties: {
          "In stock": {checkbox: true}
        }
      }
    end

    it "should call PATCH api.notion /pages/{id}" do
      client.update_page(page_id, body)

      expect(a_request(:patch, "https://api.notion.com/v1/pages/#{page_id}")
        .with(body: body))
        .to have_been_made.once
    end

    it "should match fixture response" do
      expect(client.update_page(page_id, body).parsed_response).to eq(update_page_fixture)
    end
  end
end
