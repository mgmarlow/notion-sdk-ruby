require "bundler/setup"
require "active_support/core_ext/hash/indifferent_access"
require "webmock/rspec"
require "dotenv/load"
require "vcr"
require "notion-sdk-ruby"

def load_fixture(path)
  File.read("spec/support/fixtures/#{path}.json")
end

RSpec::Matchers.define :be_like_fixture do |expected|
  match do |actual|
    actual.to_h.with_indifferent_access == JSON.parse(expected)
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<API_KEY>") { ENV["NOTION_API_KEY"] }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
