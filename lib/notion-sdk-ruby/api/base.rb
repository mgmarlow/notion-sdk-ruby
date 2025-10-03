module Notion
  module Api
    class Base
      attr_reader :request_client

      def initialize(request_client:)
        @request_client = request_client
      end
    end
  end
end
