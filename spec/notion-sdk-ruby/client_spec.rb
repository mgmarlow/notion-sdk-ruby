RSpec.describe Notion::Client do
  let(:access_token) { "foo-1234" }

  subject(:client) { described_class.new(token: access_token) }

  it "should set BASE_URI to api.notion.com" do
    expect(client.class.base_uri).to eq("https://api.notion.com")
  end

  it "should add headers" do
    expect(client.class.headers).to eq({
      Authorization: "Bearer #{access_token}",
      "Content-Type": "application/json"
    })
  end
end
