# Notion Ruby SDK

Unofficial Ruby client for the [Notion APIs](https://developers.notion.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'notion-sdk-ruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install notion-sdk-ruby

## Usage

Initialize `Notion::Client` with your app's [integration secret](https://developers.notion.com/docs/getting-started#create-a-new-integration).

```rb
require "notion-sdk-ruby"
client = Notion::Client.new(token: ENV["NOTION_API_SECRET"])

# get users
client.get_users
```

### Databases

#### #get_database

```rb
client.get_database("668d797c-76fa-4934-9b05-ad288df2d136")
```

#### #get_databases

```rb
client.get_databases
```

#### #query_database

```rb
client.query_database("668d797c-76fa-4934-9b05-ad288df2d136", {
  "filter": {
    "or": [
      {
        "property": "In stock",
        "checkbox": {
          "equals": true
        }
      },
      {
        "property": "Cost of next trip",
        "number": {
          "greater_than_or_equal_to": 2
        }
      }
    ]
  },
  "sorts": [
    {
      "property": "Last ordered",
      "direction": "ascending"
    }
  ]
})
```

### Pages

#### #get_page

```rb
client.get_page("b55c9c91-384d-452b-81db-d1ef79372b75")
```

#### #create_page

```rb
client.create_page({
  "parent": { "database_id": "48f8fee9cd794180bc2fec0398253067" },
  "properties": {
    "Name": {
      "title": [
        {
          "text": {
            "content": "Tuscan Kale"
          }
        }
      ]
    },
    "Description": {
      "rich_text": [
        {
          "text": {
            "content": "A dark green leafy vegetable"
          }
        }
      ]
    },
    "Food group": {
      "select": {
        "name": "Vegetable"
      }
    },
    "Price": { "number": 2.5 }
  },
  "children": []
})
```

#### #update_page

```rb
client.update_page("b55c9c91-384d-452b-81db-d1ef79372b75", {
  "properties": {
    "In stock": { "checkbox": true }
  }
})
```

### Blocks

#### #get_block_children

```rb
client.get_block_children("b55c9c91-384d-452b-81db-d1ef79372b75", {
  page_size: 100
})
```

#### #append_block_children

```rb
client.append_block_children("b54c9c91-384d-452b-81db-d1ef79372b75", {
  "children": [
    {
      "object": "block",
      "type": "heading_1",
      "heading_1": {
        "text": [{ "type": "text", "text": { "content": "Lacinato kale" } }]
      }
    },
    {
      "object": "block",
      "type": "paragraph",
      "paragraph": {
        "text": [
          {
            "type": "text",
            "text": {
              "content": "Lacinato kale is a variety of kale with a long tradition in Italian cuisine, especially that of Tuscany. It is also known as Tuscan kale, Italian kale, dinosaur kale, kale, flat back kale, palm tree kale, or black Tuscan palm.",
              "link": { "url": "https://en.wikipedia.org/wiki/Lacinato_kale" }
            }
          }
        ]
      }
    }
  ]
})
```

### Users

#### #get_user

```rb
client.get_user("d40e767c-d7af-4b18-a86d-55c61f1e39a4")
```

#### #get_users

```rb
client.get_users
```

### Search

#### #search

```rb
client.search({
  "query":"External tasks",
  "sort":{
    "direction":"ascending",
    "timestamp":"last_edited_time"
    }
  }
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mgmarlow/notion-sdk-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
