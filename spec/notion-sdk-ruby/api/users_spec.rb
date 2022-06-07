RSpec.describe "users" do
  let(:access_token) { ENV["NOTION_API_KEY"] }

  subject(:client) { Notion::Client.new(token: access_token) }

  describe "#get_users", :vcr do
    it "should return a list of Notion::User" do
      result = client.users.list

      aggregate_failures do
        expect(a_request(:get, "https://api.notion.com/v1/users"))
          .to have_been_made.once
        expect(result.data).to all(be_an_instance_of(Notion::User))
      end
    end

    describe "when access token is invalid" do
      let(:access_token) { "foo bar" }

      it "should raise Notion::APIResponseError" do
        expect {
          client.users.list
        }.to raise_error(Notion::APIResponseError)
      end
    end
  end

  describe "#get_user", :vcr do
    let(:user_id) { "68af0d6b-3281-4447-9d03-a6a945ecd427" }

    it "should return a Notion::User" do
      result = client.users.retrieve(user_id)

      aggregate_failures do
        expect(a_request(:get, "https://api.notion.com/v1/users/#{user_id}"))
          .to have_been_made.once
        expect(result).to be_an_instance_of(Notion::User)
      end
    end

    describe "when the user_id is not found" do
      let(:user_id) { "33af0d6b-2222-4447-9d03-a6a945ecd428" }

      it "should raise Notion::APIResponseError" do
        expect {
          client.users.retrieve(user_id)
        }.to raise_error(Notion::APIResponseError)
      end
    end
  end
end
