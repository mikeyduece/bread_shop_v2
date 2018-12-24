module Api
  module V1
    module Users
      class RecipesController < ApiController
        before_action :doorkeeper_authorize!
  
        def create
          recipe_params[:ingredients].each do |ingredient|
            ing = Ingredient.find_or_initialize_by(name: ingredient[:name])
            ing.save
            puts ing.errors.inspect
          end
        end
  
        private
  
        def recipe_params
          params.require(:recipe).permit(:name, :units, ingredients: [:name, :amount])
        end
      end
    end
  end
end