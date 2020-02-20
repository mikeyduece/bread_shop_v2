module Recipes
  class Create < ::Recipes::Base
  
    def call(&block)
      yield(Success.new(recipe), NoTrigger)
      
    rescue StandardError => e
      yield(Failure.new(I18n.t('api.errors.record_exists'), 500))
    end
    
    private

    def recipe
      recipe = user.recipes.create(params.except(:ingredients))
      add_ingredients
      
      recipe
    end
    
    def add_ingredients
      create_recipe_ingredients(recipe: recipe, ingredients: params[:ingredients])
    end
    
  end
end