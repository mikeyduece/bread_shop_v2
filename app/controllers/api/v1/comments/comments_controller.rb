module Api
  module V1
    module Comments
      class CommentsController < ApiController
        before_action :doorkeeper_authorize!
        helper_method :comment

        def create
          puts comment.inspect
          new_comment = comment.replies.create(comment_params)

          if new_comment.valid?
            success_response(code: 201, data: Comments::OverviewSerializer.new(new_comment))
          else
            error_response(code: 400, message: new_comment.errors.messages)
          end
        end

        private

        def comment
          @comment ||= Comment.find_by(id: comment_params[:parent_id])
        end

        def comment_params
          params.require(:comment).permit(:id, :body, :parent_id, :user_id)
        end
      end
    end
  end
end