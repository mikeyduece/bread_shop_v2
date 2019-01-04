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

            if new_recipe.errors.nil?
              success_response(code: 204, data: Recipes::OverviewSerializer.new(new_recipe))
            else
              error_response(code: 404, message: new_recipe.errors)
            end
          else
            error_response(code: 404, message: t('errors.record_exists'))
          end
        end

        def index
          success_response(data: Recipes::OverviewSerializer.new(current_api_user.recipes))
        end

        def show
          success_response(data: Recipes::OverviewSerializer.new(user_recipe))
        end

        def destroy
          if user_recipe
            if user_recipe.destroy
              success_response(code: 205, message: t('recipe_deleted', recipe_name: user_recipe.name))
            else
              error_response(code: 500, message: t('errors.delete_error', recipe_name: user_recipe.name))
            end
          else
            error_response(code: 404, message: t('errors.record_not_found'))
          end
        end
  
        private

        def user_recipe
          @user_recipe ||= current_api_user.recipes.find_by(id: params[:recipe_id] || params[:id])
        end
  
        def recipe_params
          params.require(:recipe).permit(:name, :units, :number_of_portions, :weight_per_portion, ingredients: [:name, :amount])
        end
      end
    end
  end
end