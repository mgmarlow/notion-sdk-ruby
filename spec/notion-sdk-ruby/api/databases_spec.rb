RSpec.describe "databases", :vcr do
  let(:access_token) { ENV["NOTION_API_KEY"] }

  subject(:client) { Notion::Client.new(token: access_token) }

  let(:database_id) { "0b99d13693254b809dfc617b1061c399" }
  let(:parent_page_id) { "783fdf36731349fba4cb6640a2d87e58" }

  describe "databases#retrieve" do
    it "should return an instance of Notion::Database" do
      result = client.databases.retrieve(database_id)

      aggregate_failures do
        expect(a_request(:get, "https://api.notion.com/v1/databases/#{database_id}"))
          .to have_been_made.once

        expect(result).to be_an_instance_of(Notion::Database)
      end
    end

    describe "when database_id is not found" do
      let(:database_id) { "0a11b11111111c111dfc111b1111c111" }

      it "should raise Notion::APIResponseError" do
        expect {
          client.databases.retrieve(database_id)
        }.to raise_error(Notion::APIResponseError)
      end
    end
  end

  describe "databases#list" do
    it "should return a list of Notion::Database" do
      result = client.databases.list

      aggregate_failures do
        expect(a_request(:get, "https://api.notion.com/v1/databases"))
          .to have_been_made.once
        expect(result.data).to all(be_an_instance_of(Notion::Database))
      end
    end
  end

  describe "databases#query" do
    let(:body) do
      {
        filter: {
          or: [
            {
              property: "In stock",
              checkbox: {
                equals: true
              }
            },
            {
              property: "Cost of next trip",
              number: {
                greater_than_or_equal_to: 2
              }
            }
          ]
        }
      }
    end

    it "should return a list of Notion::Page" do
      result = client.databases.query(database_id, body)

      aggregate_failures do
        expect(a_request(:post, "https://api.notion.com/v1/databases/#{database_id}/query")
          .with(body: body))
          .to have_been_made.once
        expect(result.data).to all(be_an_instance_of(Notion::Page))
      end
    end
  end

  describe "databases#create" do
    let(:body) do
      {
        parent: {
          type: "page_id",
          page_id: parent_page_id
        },
        title: [
          {
            type: "text",
            text: {
              content: "Grocery List",
              link: nil
            }
          }
        ],
        properties: {
          Name: {
            title: {}
          }
        }
      }
    end

    it "should return an instance of Notion::Database" do
      result = client.databases.create(body)

      aggregate_failures do
        expect(a_request(:post, "https://api.notion.com/v1/databases")
          .with(body: body))
          .to have_been_made.once
        expect(result).to be_an_instance_of(Notion::Database)
      end
    end
  end

  describe "databases#update" do
    let(:body) do
      {
        title: [
          {
            type: "text",
            text: {
              content: "Grocery List",
              link: nil
            }
          }
        ],
        properties: {
          Name: {
            title: {}
          }
        }
      }
    end

    it "should return an instance of Notion::Database" do
      result = client.databases.update(database_id, body)

      aggregate_failures do
        expect(a_request(:patch, "https://api.notion.com/v1/databases/#{database_id}")
          .with(body: body))
          .to have_been_made.once
        expect(result).to be_an_instance_of(Notion::Database)
      end
    end
  end
end
