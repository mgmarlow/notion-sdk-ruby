module Notion
  class Users
    def list
      RequestClient.active_client.get("/v1/users")
    end

    def retrieve(id)
      RequestClient.active_client.get("/v1/users/#{id}")
    end
  end
end
