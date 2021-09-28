RSpec.describe "blocks" do
  let(:access_token) { "foo-1234" }
  subject(:client) { Notion::Client.new(token: access_token) }

  let(:block_id) { "block-foo-1234" }
  let(:get_block_children_fixture) { load_fixture("blocks/200_get_block_children") }
  let(:append_block_children_fixture) { load_fixture("blocks/200_append_block_children") }
  let(:update_block_fixture) { load_fixture("blocks/200_update_block") }
  let(:get_block_fixture) { load_fixture("blocks/200_retrieve_block") }

  before do
    stub_request(:get, "https://api.notion.com/v1/blocks/#{block_id}")
      .to_return(body: get_block_fixture)

    stub_request(:patch, "https://api.notion.com/v1/blocks/#{block_id}")
      .to_return(body: update_block_fixture)

    stub_request(:get, "https://api.notion.com/v1/blocks/#{block_id}/children")
      .to_return(body: get_block_children_fixture)

    stub_request(:patch, "https://api.notion.com/v1/blocks/#{block_id}/children")
      .to_return(body: append_block_children_fixture)
  end

  describe "blocks#retrieve" do
    it "should call GET api.notion /blocks/{id}" do
      client.blocks.retrieve(block_id)

      expect(a_request(:get, "https://api.notion.com/v1/blocks/#{block_id}"))
        .to have_been_made.once
    end

    it "should match fixture response" do
      expect(client.blocks.retrieve(block_id).parsed_response).to eq(get_block_fixture)
    end
  end

  describe "blocks#update" do
    let(:body) do
      {
        to_do: {
          text: [{
            text: {content: "Lacinato kale"}
          }],
          checked: false
        }
      }
    end

    it "should call PATCH api.notion /blocks/{id}" do
      client.blocks.update(block_id, body)

      expect(a_request(:patch, "https://api.notion.com/v1/blocks/#{block_id}"))
        .to have_been_made.once
    end

    it "should match fixture response" do
      expect(client.blocks.update(block_id, body).parsed_response).to eq(update_block_fixture)
    end
  end

  describe "blocks#children#list" do
    it "should call GET api.notion /blocks/{id}/children" do
      client.blocks.children.list(block_id)

      expect(a_request(:get, "https://api.notion.com/v1/blocks/#{block_id}/children"))
        .to have_been_made.once
    end

    it "should match fixture response" do
      expect(client.blocks.children.list(block_id).parsed_response).to eq(get_block_children_fixture)
    end
  end

  describe "blocks#children#append" do
    let(:child) do
      {
        object: "block",
        type: "heading_2",
        heading_2: {
          text: [
            {
              type: "text",
              text: {
                content: "Foo Bar Heading"
              }
            }
          ]
        }
      }
    end

    let(:body) { {children: [child]} }

    it "should call PATCH api.notion /blocks/{id}/children" do
      client.blocks.children.append(block_id, body)

      expect(a_request(:patch, "https://api.notion.com/v1/blocks/#{block_id}/children")
        .with(body: body, headers: {'Content-Type': "application/json", Authorization: "Bearer #{access_token}"}))
        .to have_been_made.once
    end

    it "should match fixture response" do
      expect(client.blocks.children.append(block_id, body).parsed_response).to eq(append_block_children_fixture)
    end
  end
end
