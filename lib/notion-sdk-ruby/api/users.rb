module Notion
  module Api
    class Users
      include RequestClient

      # @return [Array<Notion::User>]
      def list
        response = get("/v1/users")
        List.new(response.body)
      end

      # @param [String] id user_id
      # @return [Notion::User]
      def retrieve(id)
        response = get("/v1/users/#{id}")
        User.new(response.body)
      end
    end
  end
end
