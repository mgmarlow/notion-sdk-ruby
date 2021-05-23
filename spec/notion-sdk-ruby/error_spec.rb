RSpec.describe Notion::ErrorFactory do
  subject(:factory) { described_class }

  describe "#create" do
    describe "empty error" do
      it "should return Unknown Error" do
        result = factory.create
        expect(result).to be_a Notion::NotionError
        expect(result.message).to eq "Unknown error."
      end
    end

    describe "code inside API_ERROR_CODE" do
      let(:error) do
        {
          "code" => Notion::API_ERROR_CODE[:object_not_found],
          "message" => "object not found, yo"
        }
      end

      it "should return APIResponseError" do
        result = factory.create(error)
        expect(result).to be_a Notion::APIResponseError
        expect(result.message).to eq error["message"]
        expect(result.code).to eq error["code"]
      end
    end

    describe "code NOT inside API_ERROR_CODE" do
      let(:error) do
        {
          "code" => "some_random_code",
          "message" => "some random error message not handled in library"
        }
      end

      it "should return APIResponseError" do
        result = factory.create(error)
        expect(result).to be_a Notion::NotionError
        expect(result.message).to eq error["message"]
      end
    end

    describe "error has request, response, and timings" do
      let(:error) do
        {
          "request" => "request info",
          "response" => "response info",
          "timings" => "timings info",
          "message" => "HTTP error!"
        }
      end

      it "should return APIResponseError" do
        result = factory.create(error)
        expect(result).to be_a Notion::HTTPResponseError
        expect(result.message).to eq error["message"]
      end
    end

    describe "error has request, timings, NOT response" do
      let(:error) do
        {
          "request" => "request info",
          "timings" => "timings info",
          "message" => "Timeout!"
        }
      end

      it "should return APIResponseError" do
        result = factory.create(error)
        expect(result).to be_a Notion::RequestTimeoutError
        expect(result.message).to eq error["message"]
      end
    end

    describe "error only has message" do
      let(:error) do
        {
          "message" => "very descriptive error message"
        }
      end

      it "should return APIResponseError" do
        result = factory.create(error)
        expect(result).to be_a Notion::NotionError
        expect(result.message).to eq error["message"]
      end
    end
  end
end
