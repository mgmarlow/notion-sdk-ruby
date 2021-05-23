RSpec.describe Notion::RequestClient do
  let(:access_token) { "foo-1234" }
  let(:config) do
    OpenStruct.new({
      api_token: access_token
    })
  end

  subject(:client) { described_class.new(config) }

  it "should set BASE_URI to api.notion.com" do
    expect(client.class.base_uri).to eq("https://api.notion.com")
  end

  it "should add headers" do
    expect(client.class.headers).to eq({
      Authorization: "Bearer #{access_token}",
      "Content-Type": "application/json"
    })
  end

  describe "#raise_on_failure" do
    describe "response#success? is true" do
      let(:response) do
        OpenStruct.new({
          success?: true,
          data: {type: "foo-bar"}
        })
      end

      it "should return response" do
        expect(client.raise_on_failure(response)).to eq(response)
      end
    end

    describe "response#success? is false" do
      let(:response) do
        OpenStruct.new({
          success?: false
        })
      end

      before { allow(Notion::ErrorFactory).to receive(:create).and_return(Notion::NotionError.new) }

      it "should raise an error created from ErrorFactory" do
        expect { client.raise_on_failure(response) }.to raise_error(Notion::NotionError)
      end
    end
  end
end
