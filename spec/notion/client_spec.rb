require "json"

RSpec.describe Notion::Client do
  let(:access_token) { "foo-1234" }

  subject(:client) { described_class.new(token: access_token) }

  it "should set BASE_URI to api.notion.com" do
    expect(client.class.base_uri).to eq("https://api.notion.com")
  end

  it "should add access_token to headers" do
    expect(client.class.headers).to eq({
      Authorization: "Bearer #{access_token}"
    })
  end

  describe "users" do
    let(:user_id) { "abcd-1234" }
    let(:get_users_fixture) { load_fixture("spec/fixtures/users/200_get_users") }
    let(:get_user_fixture) { load_fixture("spec/fixtures/users/200_get_user") }

    before do
      stub_request(:get, "https://api.notion.com/v1/users")
        .to_return(body: get_users_fixture)

      stub_request(:get, "https://api.notion.com/v1/users/#{user_id}")
        .to_return(body: get_user_fixture)
    end

    it "should get_users" do
      expect(client.get_users.parsed_response).to eq(get_users_fixture)
    end

    it "should get_user by ID" do
      expect(client.get_user(user_id).parsed_response).to eq(get_user_fixture)
    end
  end
end
