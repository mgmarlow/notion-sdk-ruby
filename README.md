# Notion Ruby SDK

[![ci](https://github.com/mgmarlow/notion-sdk-ruby/actions/workflows/ci.yml/badge.svg)](https://github.com/mgmarlow/notion-sdk-ruby/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/notion-sdk-ruby.svg)](https://badge.fury.io/rb/notion-sdk-ruby)

Unofficial Ruby client for the [Notion APIs](https://developers.notion.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'notion-sdk-ruby'
```

And then execute:

```
$ bundle install
```
    
## Documentation

- [API documentation](https://mgmarlow.github.io/notion-sdk-ruby/Notion/Client.html)
- [Examples](./examples/)

## Usage

Initialize `Notion::Client` with your app's [integration secret](https://developers.notion.com/docs/getting-started#create-a-new-integration).

```rb
require "notion-sdk-ruby"
client = Notion::Client.new(token: ENV["NOTION_API_SECRET"])
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

Before using `bin/console` you need to create a new file, `.env`, at the root project directory. This will enable you to run commands directly against your [Notion integration](https://developers.notion.com/docs/getting-started).

```
cat > .env <<EOF
NOTION_API_KEY=<YOUR NOTION API SECRET HERE>
EOF
```

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mgmarlow/notion-sdk-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
