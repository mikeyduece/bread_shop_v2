class Api::V1::Recipes::CommentsController < ApiController
  before_action :doorkeeper_authorize!
  helper_method :recipe, :comment

  def index
    success_response(data: ::Comments::OverviewSerializer.new(recipe.comments))
  end

  def show
    
  end

  def update
    
  end

  def destroy
    
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