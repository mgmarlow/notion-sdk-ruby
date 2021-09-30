RSpec.describe "databases" do
  let(:access_token) { "foo-1234" }
  subject(:client) { Notion::Client.new(token: access_token) }

  let(:database_id) { "abcd-database-1234" }
  let(:get_database_fixture) { load_fixture("databases/200_get_database") }
  let(:get_databases_fixture) { load_fixture("databases/200_get_databases") }
  let(:query_database_fixture) { load_fixture("databases/200_query_database") }
  let(:create_database_fixture) { load_fixture("databases/200_create_database") }
  let(:update_database_fixture) { load_fixture("databases/200_update_database") }

  before do
    stub_request(:get, "https://api.notion.com/v1/databases/#{database_id}")
      .to_return(body: get_database_fixture)

    stub_request(:get, "https://api.notion.com/v1/databases")
      .to_return(body: get_databases_fixture)

    stub_request(:post, "https://api.notion.com/v1/databases/#{database_id}/query")
      .to_return(body: query_database_fixture)

    stub_request(:post, "https://api.notion.com/v1/databases")
      .to_return(body: create_database_fixture)

    stub_request(:patch, "https://api.notion.com/v1/databases/#{database_id}")
      .to_return(body: update_database_fixture)
  end

  describe "databases#retrieve" do
    it "should call GET api.notion /databases" do
      client.databases.retrieve(database_id)

      expect(a_request(:get, "https://api.notion.com/v1/databases/#{database_id}"))
        .to have_been_made.once
    end

    it "should return an instance of Notion::Database" do
      expect(client.databases.retrieve(database_id)).to be_an_instance_of(Notion::Database)
    end

    it "should match fixture response" do
      expect(client.databases.retrieve(database_id)).to be_like_fixture(get_database_fixture)
    end
  end

  describe "databases#list" do
    it "should call GET api.notion /databases" do
      client.databases.list

      expect(a_request(:get, "https://api.notion.com/v1/databases"))
        .to have_been_made.once
    end

    it "should include database models" do
      expect(client.databases.list.data).to all(be_an_instance_of(Notion::Database))
    end

    it "should match fixture response" do
      items = client.databases.list.data.map(&:to_h)
      expected = JSON.parse(get_databases_fixture)["results"]

      items.each_with_index do |item, i|
        expect(item.to_json).to eq(expected[i].to_json)
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
        },
        sorts: [
          {
            property: "Last ordered",
            direction: "ascending"
          }
        ]
      }
    end

    it "should call POST api.notion /databases/{id}/query" do
      client.databases.query(database_id, body)

      expect(a_request(:post, "https://api.notion.com/v1/databases/#{database_id}/query")
        .with(body: body))
        .to have_been_made.once
    end

    it "should include user models" do
      expect(client.databases.query(database_id, body).data).to all(be_an_instance_of(Notion::Page))
    end

    it "should match fixture response" do
      items = client.databases.query(database_id, body).data.map(&:to_h)
      expected = JSON.parse(query_database_fixture)["results"]

      items.each_with_index do |item, i|
        expect(item.to_json).to eq(expected[i].to_json)
      end
    end
  end

  describe "databases#create" do
    let(:body) do
      {
        parent: {
          type: "page_id",
          page_id: "98ad959b-2b6a-4774-80ee-00246fb0ea9b"
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

    it "should call POST api.notion /databases" do
      client.databases.create(body)

      expect(a_request(:post, "https://api.notion.com/v1/databases")
        .with(body: body))
        .to have_been_made.once
    end

    it "should return an instance of Notion::Database" do
      expect(client.databases.create(body)).to be_an_instance_of(Notion::Database)
    end

    it "should match fixture response" do
      expect(client.databases.create(body)).to be_like_fixture(create_database_fixture)
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

    it "should call POST api.notion /databases" do
      client.databases.update(database_id, body)

      expect(a_request(:patch, "https://api.notion.com/v1/databases/#{database_id}")
        .with(body: body))
        .to have_been_made.once
    end

    it "should return an instance of Notion::Database" do
      expect(client.databases.update(database_id, body)).to be_an_instance_of(Notion::Database)
    end

    it "should match fixture response" do
      expect(client.databases.update(database_id, body)).to be_like_fixture(update_database_fixture)
    end
  end
end
