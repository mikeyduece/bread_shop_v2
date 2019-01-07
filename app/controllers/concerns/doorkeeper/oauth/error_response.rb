module Doorkeeper
  module OAuth
    class ErrorResponse
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