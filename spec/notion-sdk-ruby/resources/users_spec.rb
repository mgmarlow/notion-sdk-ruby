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
      client.users.list

      expect(a_request(:get, "https://api.notion.com/v1/users"))
        .to have_been_made.once
    end

    it "should match fixture response" do
      expect(client.users.list.body).to eq(get_users_fixture)
    end
  end

  describe "#get_user" do
    it "should call api.notion /users/{id}" do
      client.users.retrieve(user_id)

      expect(a_request(:get, "https://api.notion.com/v1/users/#{user_id}"))
        .to have_been_made.once
    end

    it "should match fixture response" do
      expect(client.users.retrieve(user_id).body).to eq(get_user_fixture)
    end
  end

  describe "user_id not found" do
    let(:user_id) { "1234" } # match fixture
    let(:get_user_failure_fixture) { load_fixture("users/404_get_user") }

    before do
      stub_request(:get, "https://api.notion.com/v1/users/#{user_id}")
        .to_return(body: get_user_failure_fixture, status: 404, headers: {
          'Content-Type': "application/json"
        })
    end

    it "should raise Notion::APIResponseError" do
      expect {
        client.users.retrieve(user_id)
      }.to raise_error(an_instance_of(Notion::APIResponseError)
        .and(having_attributes(message: "Could not find user with ID: #{user_id}.")))
    end
  end
end
