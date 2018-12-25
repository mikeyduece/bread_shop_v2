module Api
  module V1
    module Users
      class RecipesController < ApiController
        include Api::RecipeHelper
        before_action :doorkeeper_authorize!
        helper_method :user_recipe
  
        def create
          recipe = current_api_user.recipes.find_by(name: recipe_params[:name].downcase)

          if !recipe
            new_recipe = create_recipe(user: current_api_user, params: recipe_params)
            success_response(code: 204, data: RecipeSerializer.new(new_recipe, options))
          else
            error_response(code: 404, message: t('api.errors.record_exists'))
          end
        end

        def index
          success_response(data: RecipeSerializer.new(current_api_user.recipes, options))
        end

        def show
          success_response(data: RecipeSerializer.new(user_recipe, options))
        end

        def destroy
          user_recipe.destroy
          success_response(code: 205, message: t('api.recipe_deleted', recipe_name: user_recipe.name))
        end
  
        private

        def options
          {
            include: %i[user family]
          }
        end

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