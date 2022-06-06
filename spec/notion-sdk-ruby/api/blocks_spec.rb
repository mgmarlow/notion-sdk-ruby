RSpec.describe "blocks", :vcr do
  let(:access_token) { ENV["NOTION_API_KEY"] }

  subject(:client) { Notion::Client.new(token: access_token) }

  let(:block_id) { "4cc50934dd4f42fc94952c2b2a727c4f" }

  describe "#blocks#retrieve" do
    it "should return an instance of Notion::Block" do
      result = client.blocks.retrieve(block_id)

      aggregate_failures do
        expect(a_request(:get, "https://api.notion.com/v1/blocks/#{block_id}"))
          .to have_been_made.once
        expect(result).to be_an_instance_of(Notion::Block)
      end
    end

    describe "when block ID isn't found" do
      let(:block_id) { "foo-bar" }

      it "should raise Notion::APIResponseError" do
        expect {
          client.blocks.retrieve(block_id)
        }.to raise_error(Notion::APIResponseError)
      end
    end
  end

  describe "blocks#update" do
    let(:body) do
      {
        heading_1: {
          text: [{
            text: {content: "Lacinato kale"}
          }]
        }
      }
    end

    it "should return an instance of Notion::Block" do
      result = client.blocks.update(block_id, body)

      aggregate_failures do
        expect(a_request(:patch, "https://api.notion.com/v1/blocks/#{block_id}"))
          .to have_been_made.once
        expect(result).to be_an_instance_of(Notion::Block)
      end
    end

    describe "when block ID isn't found" do
      let(:block_id) { "foo-bar" }

      it "should raise Notion::APIResponseError" do
        expect {
          client.blocks.update(block_id, body)
        }.to raise_error(Notion::APIResponseError)
      end
    end
  end

  describe "blocks#children#list" do
    let(:query) { {start_cursor: nil} }

    # TODO: fix issues w/ expected string values
    # it "should allow request params" do
    #   client.blocks.children.list(block_id, query)

    #   expect(a_request(:get, "https://api.notion.com/v1/blocks/#{block_id}/children?start_cursor=undefined"))
    #     .to have_been_made.once
    # end

    it "should return a list of Notion::Blocks" do
      result = client.blocks.children.list(block_id)
      expect(result.data).to all(be_an_instance_of(Notion::Block))
    end

    describe "when block ID isn't found" do
      let(:block_id) { "foo-bar" }

      it "should raise Notion::APIResponseError" do
        expect {
          client.blocks.children.list(block_id, {foo: "bar"})
        }.to raise_error(Notion::APIResponseError)
      end
    end
  end

  describe "blocks#children#append" do
    let(:block_id) { "895d489280a3475c906a44c06723a022" }
    let(:body) do
      {children: [
        {
          to_do: {
            text: [{
              text: {content: "Lacinato kale"}
            }],
            checked: false
          }
        }
      ]}
    end

    it "should return a list of Notion::Blocks" do
      result = client.blocks.children.append(block_id, body)

      aggregate_failures do
        expect(a_request(:patch, "https://api.notion.com/v1/blocks/#{block_id}/children"))
          .to have_been_made.once
        expect(result.data).to all(be_an_instance_of(Notion::Block))
      end
    end

    describe "when block ID isn't found" do
      let(:block_id) { "foo-bar" }

      it "should raise Notion::APIResponseError" do
        expect {
          client.blocks.children.append(block_id, body)
        }.to raise_error(Notion::APIResponseError)
      end
    end

    describe "when body is missing" do
      let(:body) { nil }

      it "should raise Notion::APIResponseError" do
        expect {
          client.blocks.children.append(block_id, body)
        }.to raise_error(Notion::APIResponseError)
      end
    end
  end
end
