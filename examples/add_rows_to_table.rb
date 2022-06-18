require "dotenv/load"
require "notion-sdk-ruby"

database_id = "6f0249dd822f4419bdb884cec583c21d"
client = Notion::Client.new(token: ENV["NOTION_API_KEY"])

coffees = [
  {
    name: "Bird Rock Blend",
    roaster: "Bird Rock",
    rating: 5
  },
  {
    name: "Cafe Capitan",
    roaster: "Good Citizen",
    rating: 3
  },
  {
    name: "La Familia Guarnizo",
    roaster: "Joe Coffee",
    rating: 3
  }
]

coffees.each do |coffee|
  client.pages.create({
    parent: {
      database_id: database_id
    },
    properties: {
      Name: {
        title: [
          {
            text: {
              content: coffee[:name]
            }
          }
        ]
      },
      Roaster: {
        rich_text: [
          text: {
            content: coffee[:roaster]
          }
        ]
      },
      Rating: {
        number: coffee[:rating]
      }
    }
  })
end
