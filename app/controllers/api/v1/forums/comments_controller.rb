module Api
  module V1
    module Forums
      class CommentsController < ApiController
        before_action :doorkeeper_authorize!
        helper_method :forum

        def create
          comment = forum.comments.create(comment_params)

          if comment.errors.messages.empty?
            success_response(code: 201, data: Forums::Comments::OverviewSerializer.new(comment))
          else
            error_response(code: 404, message: comment.errors.messages)
          end
        end

        def destroy
          if comment
            if comment.destroy
              success_response(message: t('api.comments.deleted'))
            else
              error_response(message: t('api.error.delete_error', name: 'comment'))
              end
          else
            error_response(message: t('api.error.record_not_found'))
          end
        end

        private

        def comment
          @comment ||= Comment.find_by(id: params[:comment_id] || params[:id])          
        end
        
        def forum
          @forum ||= Forum.find_by(id: params[:forum_id] || params[:id])
        end

        def comment_params
          params.require(:comment).permit(:id, :body, :user_id, :parent_id)
        end
      end
    end
  end
end