lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative "lib/notion-sdk-ruby/version"

Gem::Specification.new do |spec|
  spec.name = "notion-sdk-ruby"
  spec.version = Notion::VERSION
  spec.authors = ["Graham Marlow"]
  spec.email = ["mgmarlow@hey.com"]

  spec.summary = "Notion SDK"
  spec.homepage = "https://github.com/mgmarlow/notion-sdk-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mgmarlow/notion-sdk-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/mgmarlow/notion-sdk-ruby/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 1.8"
  spec.add_dependency "faraday_middleware", "~> 1.1"

  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "standardrb", "~> 1.0"
  spec.add_development_dependency "webmock", "~> 3.12"
  spec.add_development_dependency "pry", "~> 0.14.1"
  spec.add_development_dependency "dotenv", "~> 2.7"
end
