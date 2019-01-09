module Api
  module V1
    module Forums
      class CommentsController < WebController
        before_action :doorkeeper_authorize!

        private

        def comment_params
          params.require(:comment).permit(:id, :body, :user_id, :parent_id)
        end
      end
    end
  end
end