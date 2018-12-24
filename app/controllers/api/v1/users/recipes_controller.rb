module Api
  module V1
    module Users
      class RecipesController < ApiController
        before_action :doorkeeper_authorize!
  
        def create
          
        end
  
        private
  
        def recipe_params
          params.require(:recipe).permit(:name, :units, ingredients: [:name, :amount])
        end
      end
    end
  end
end