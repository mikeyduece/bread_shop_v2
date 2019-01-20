module Api
  module V1
    module Recipes
      class RecipesController < ApiController
        before_action :doorkeeper_authorize!
        helper_method :recipe

        def show
          if recipe
            success_response(data: Recipes::OverviewSerializer.new(recipe))        
          else
            error_response(code: 404, message: 'Recipe Not Found')
          end
        end

        def scale
          if recipe
            success_response(data: Recipes::ScaledSerializer.new(recipe, { params: { params: recipe_params } }))
          else
            error_response(code: 404, message: t('api.defaults.not_found'))
          end

        end
  
        private

        def recipe_params
          params.require(:recipe).permit(:weight_per_portion, :number_of_portions)
        end
  
        def recipe
          @recipe = Recipe.find_by(id: params[:recipe_id] || params[:id])
        end
      end
    end
  end
end