module Api
  module V1
    module Users
      class RecipesController < ApiController
        include Api::RecipeHelper
        before_action :doorkeeper_authorize!
        helper_method :user_recipe
  
        def create
          recipe = current_api_user.recipes.find_by(name: recipe_params[:name].downcase)

          if recipe
            error_response(code: 404, message: t('api.errors.record_exists'))
          else
            new_recipe = create_recipe(recipe_params)
            success_response(code: 204, options: RecipeSerializer.new(new_recipe))
          end
        end

        def index
          success_response(options: RecipeSerializer.new(current_api_user.recipes))
        end

        def show
          success_response(options: RecipeSerializer.new(user_recipe))
        end
  
        private

        def user_recipe
          @user_recipe ||= current_api_user.recipes.find_by(id: params[:recipe_id] || params[:id])
        end
  
        def recipe_params
          params.require(:recipe).permit(:name, :units, ingredients: [:name, :amount])
        end
      end
    end
  end
end