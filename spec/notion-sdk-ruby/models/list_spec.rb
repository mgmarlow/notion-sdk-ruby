RSpec.describe Notion::List do
  let(:results) { [] }
  let(:next_cursor) {}
  let(:has_more) { false }
  let(:response_body) do
    {
      "results" => results,
      "next_cursor" => next_cursor,
      "has_more" => has_more
    }
  end

  subject(:model) { described_class }

  RSpec.shared_examples "list data response" do |expected|
    it "should return Array<#{expected}>" do
      result = model.new(response_body)
      expect(result.data).to all(be_an_instance_of(expected))
    end
  end

  context "when data consists of users" do
    let(:results) do
      [
        {"object" => "user"}
      ]
    end

    it_behaves_like "list data response", Notion::User
  end

  context "when data consists of blocks" do
    let(:results) do
      [
        {"object" => "block"}
      ]
    end

    it_behaves_like "list data response", Notion::Block
  end

  context "when data consists of pages" do
    let(:results) do
      [
        {"object" => "page"}
      ]
    end

    it_behaves_like "list data response", Notion::Page
  end

  context "when data consists of databases" do
    let(:results) do
      [
        {"object" => "database"}
      ]
    end

    it_behaves_like "list data response", Notion::Database
  end

  context "when data consists of unknown objects" do
    let(:results) do
      [
        {"object" => "foobar"}
      ]
    end

    it "should raise Notion::Error" do
      expect { model.new(response_body) }
        .to raise_error(/unimplemented/)
    end
  end
end
