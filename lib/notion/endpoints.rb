module Notion
  module Endpoints
    include Databases
    include Pages
    include Blocks
    include Users
    include Search
  end
end
