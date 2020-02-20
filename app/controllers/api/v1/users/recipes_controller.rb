module Api
  module V1
    module Users
      class RecipesController < ApiController
        include Api::RecipeHelper
        before_action :doorkeeper_authorize!
        helper_method :user_recipe
  
        def create
          recipe = current_api_user.recipes.find_by(name: recipe_params[:name].downcase)
          return error_response(code: 404, message: t('api.errors.record_exists')) if recipe
          
          Recipes::Create.call(user: current_api_user, params: recipe_params) do |success, failure|
            success.call {}
            failure.call {}
          end

        #  unless recipe.present?
        #    new_recipe = create_recipe(user: current_api_user, params: recipe_params)
        #
        #    if new_recipe.valid?
        #      success_response(code: 201, data: Recipes::OverviewSerializer.new(new_recipe))
        #    else
        #      error_response(code: 404, message: new_recipe.errors)
        #    end
        #  else
        #    error_response(code: 404, message: t('api.errors.record_exists'))
        #  end
        #end

        def index
          success_response(data: Recipes::OverviewSerializer.new(current_api_user.recipes))
        end

        def show
          success_response(data: Recipes::OverviewSerializer.new(user_recipe))
        end

        def update
          user_recipe.update_recipe(params: recipe_params)
          success_response(data: Recipes::OverviewSerializer.new(user_recipe))
        end

        def destroy
          if user_recipe.present?
            recipe_name = user_recipe.name
            user_recipe.destroy
            success_response(code: 202, message: t('api.recipes.recipe_deleted', recipe_name: recipe_name))
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