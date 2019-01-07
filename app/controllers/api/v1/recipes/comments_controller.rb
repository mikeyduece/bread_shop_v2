module Api
  module V1
    module Recipes
      class CommentsController < ApiController
        
        before_action :doorkeeper_authorize!
        helper_method :recipe, :comment
      
        def index
          success_response(data: Api::V1::Comments::OverviewSerializer.new(recipe.comments.roots))
        end
      
        def create
          new_comment = recipe.comments.new(comment_params)
          
          if new_comment.valid?
            new_comment.save
      
            success_response(data: Comments::OverviewSerializer.new(new_comment))
          else
            error_response(code: 404, message: t('api.comments.error'))
          end
        end
      
        def show
          success_response(data: Comments::OverviewSerializer.new(comment))
        end
      
        def update
          if comment.update(comment_params)
            success_response(data: Comments::OverviewSerializer.new(comment))
          else
            error_response(code: 500, message: t('api.comments.error'))
          end
        end
      
        def destroy
          if comment.destroy
            success_response(code: 201, message: t('api.comments.deleted'))
          else
            error_response(code: 500, message: t('api.comments.delete_error'))
          end
        end
      
        private
      
        def comment_params
          params.require(:comment).permit(:id, :parent_id, :recipe_id, :user_id, :body)
        end
      
        def recipe
          @recipe ||= Recipe.find_by(id: params[:recipe_id] || params[:id])
        end
      
        def comment
          @comment ||= Comment.find_by(id: params[:comment_id] || params[:id])
        end
      end
    end
  end
end
