RSpec.describe Notion::RequestClient do
  subject(:service) do
    mock_class = Class.new do
      include Notion::RequestClient

      def call
        get("https://example.com")
      end
    end

    mock_class.new
  end

  describe "error handling" do
    context "malformed JSON" do
      let(:notion_error) { "{" }

      before do
        stub_request(:get, "https://example.com")
          .to_return(body: notion_error.to_json, status: 400, headers: {
            "Content-Type": "application/json"
          })
      end

      it "should raise Notion::NotionError" do
        expect {
          service.call
        }.to raise_error(an_instance_of(Notion::NotionError))
      end
    end

    context "404 error" do
      let(:status) { 404 }
      let(:error_message) { "Could not find user" }
      let(:notion_error) do
        {
          "object" => "error",
          "status" => status,
          "code" => "object_not_found",
          "message" => error_message
        }.to_json
      end

      before do
        stub_request(:get, "https://example.com")
          .to_return(body: notion_error, status: status, headers: {
            "Content-Type": "application/json"
          })
      end

      it "should raise Notion::APIResponseError" do
        expect {
          service.call
        }.to raise_error(an_instance_of(Notion::APIResponseError)
          .and(having_attributes(message: error_message)))
      end
    end

    RSpec.shared_examples "api error" do |error_code|
      let(:notion_error) do
        {
          "object" => "error",
          "status" => 400,
          "code" => error_code,
          "message" => "foo error"
        }.to_json
      end

      before do
        stub_request(:get, "https://example.com")
          .to_return(body: notion_error, status: 400, headers: {
            "Content-Type": "application/json"
          })
      end

      it "should raise Notion::APIResponseError" do
        expect {
          service.call
        }.to raise_error(an_instance_of(Notion::APIResponseError))
      end
    end

    it_behaves_like "api error", "unauthorized"
    it_behaves_like "api error", "restricted_resource"
    it_behaves_like "api error", "object_not_found"
    it_behaves_like "api error", "rate_limited"
    it_behaves_like "api error", "invalid_json"
    it_behaves_like "api error", "invalid_request_url"
    it_behaves_like "api error", "invalid_request"
    it_behaves_like "api error", "validation_error"
    it_behaves_like "api error", "conflict_error"
    it_behaves_like "api error", "internal_server_error"
    it_behaves_like "api error", "service_unavailable"
  end
end
