module Notion
  module Api
    class UsersMethods
      include RequestClient

      # Returns a paginated list of Users for the workspace.
      # https://developers.notion.com/reference/get-users
      # @return [Array<Notion::User>]
      def list
        response = get("/v1/users")
        List.new(response.body)
      end

      # Retrieves a User using the ID specified.
      # https://developers.notion.com/reference/get-user
      # @param [String] id user_id
      # @return [Notion::User]
      def retrieve(id)
        response = get("/v1/users/#{id}")
        User.new(response.body)
      end
    end
  end
end
