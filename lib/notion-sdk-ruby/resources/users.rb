module Notion
  class Users
    include RequestClient

    def list
      get("/v1/users")
    end

    def retrieve(id)
      get("/v1/users/#{id}")
    end
  end
end
