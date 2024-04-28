# frozen_string_literal: true

module Api
  module V1
    module Recipes
      class CommentsController < ApiController
        before_action :doorkeeper_authorize!
        helper_method :recipe
        helper_method :comment

        def create
          new_comment = recipe.comments.new(comment_params)

          if new_comment.save
            success_response(data: Comments::OverviewSerializer.new(new_comment))
          else
            error_response(code: 404, message: t('comments.error'))
          end
        end

        def show
          success_response(data: Comments::OverviewSerializer.new(comment))
        end

        def update
          if comment.update(comment_params)
            success_response(data: Comments::OverviewSerializer.new(comment))
          else
            error_response(code: 500, message: t('comments.error'))
          end
        end

        def destroy
          if comment.destroy
            success_response(code: 201, message: t('comments.deleted'))
          else
            error_response(code: 500, message: t('comments.delete_error'))
          end
        end

        private def comment_params
          params.require(:comment).permit(:id, :parent_id, :user_id, :body)
        end

        private def recipe
          @recipe ||= Recipe.find_by(id: params[:recipe_id] || params[:id])
        end

        private def comment
          @comment ||= Comment.find_by(id: params[:comment_id] || params[:id])
        end
      end
    end
  end
end
