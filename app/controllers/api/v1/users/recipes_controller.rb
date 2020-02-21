module Api
  module V1
    module Users
      class RecipesController < ApiController
        include Api::RecipeHelper
        before_action :doorkeeper_authorize!
        before_action :set_user_recipe, except: :create
        
        def create
          recipe = current_api_user.recipes.find_by(name: recipe_params[:name].downcase)
          return error_response(code: 404, message: t('api.errors.record_exists')) if recipe
          
          ::Recipes::Create.call(current_api_user, recipe_params) do |success, failure|
            success.call { |recipe| success_response(data: Recipes::OverviewSerializer.new(recipe)) }
            
            failure.call(&method(:error_response))
          end
        end
        
        def index
          success_response(data: Recipes::OverviewSerializer.new(current_api_user.recipes))
        end
        
        def show
          success_response(data: Recipes::OverviewSerializer.new(@user_recipe))
        end
        
        def update
          @user_recipe.update_recipe(params: recipe_params)
          success_response(data: Recipes::OverviewSerializer.new(@user_recipe))
        end
        
        def destroy
          return error_response(code: 404, message: t('errors.record_not_found')) unless @user_recipe.present?
          
          recipe_name = @user_recipe.name
          @user_recipe.destroy
          
          success_response(code: 202, message: t('api.recipes.recipe_deleted', recipe_name: recipe_name))
        end
        
        private
        
        def set_user_recipe
          @user_recipe ||= current_api_user.recipes.find_by(id: params[:recipe_id] || params[:id])
        end
        
        def recipe_params
          params.require(:recipe).permit(:name, :units, :number_of_portions, :weight_per_portion, ingredients: [:name, :amount])
        end
      end
    end
  end
end