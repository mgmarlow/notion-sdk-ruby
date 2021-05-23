module Notion
  module Users
    def get_users
      get("/v1/users")
    end

    def get_user(id)
      get("/v1/users/#{id}")
    end
  end
end
