module Doorkeeper
  module OAuth
    class ErrorResponse < BaseResponse
      def body
        {
          error:
            {
              key: name,
              message: description
            }
        }
      end
    end
  end
end