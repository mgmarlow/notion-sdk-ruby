module Notion
  class Users
    include RequestClient

    def list
      response = get("/v1/users")
      List.new(response.body)
    end

    def retrieve(id)
      response = get("/v1/users/#{id}")
      User.new(response.body)
    end
  end
end
