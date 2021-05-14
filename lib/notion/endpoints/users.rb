module Notion
  module Endpoints
    module Users
      def get_users
        self.class.get("/v1/users")
      end

      def get_user(id)
        self.class.get("/v1/users/#{id}")
      end
    end
  end
end
