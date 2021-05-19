RSpec.describe "users" do
  let(:access_token) { "foo-1234" }
  subject(:client) { Notion::Client.new(token: access_token) }

  let(:user_id) { "abcd-1234" }
  let(:get_users_fixture) { load_fixture("users/200_get_users") }
  let(:get_user_fixture) { load_fixture("users/200_get_user") }

  before do
    stub_request(:get, "https://api.notion.com/v1/users")
      .to_return(body: get_users_fixture)

    stub_request(:get, "https://api.notion.com/v1/users/#{user_id}")
      .to_return(body: get_user_fixture)
  end

  describe "#get_users" do
    it "should call api.notion /users/" do
      client.get_users

      expect(a_request(:get, "https://api.notion.com/v1/users"))
        .to have_been_made.once
    end

    it "should match fixture response" do
      expect(client.get_users.parsed_response).to eq(get_users_fixture)
    end
  end

  describe "#get_user" do
    it "should call api.notion /users/{id}" do
      client.get_user(user_id)

      expect(a_request(:get, "https://api.notion.com/v1/users/#{user_id}"))
        .to have_been_made.once
    end

    it "should match fixture response" do
      expect(client.get_user(user_id).parsed_response).to eq(get_user_fixture)
    end
  end
end
