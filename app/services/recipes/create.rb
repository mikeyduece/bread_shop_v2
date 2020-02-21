module Recipes
  class Create < ::Recipes::Base
  
    def call(&block)
      yield(Success.new(recipe), NoTrigger)
      
    rescue ActiveRecord::RecordNotUnique => e
      yield(NoTrigger, Failure.new(I18n.t('api.errors.recipes.record_exists'), 500))
    rescue StandardError => e
      yield(NoTrigger, Failure.new(e.message, 500))
    end
    
    private

    def recipe
      require 'pry'; binding.pry
      @recipe = user.recipes.build(params.except(:ingredients))
      add_ingredients
      
      @recipe
    end
    
    def add_ingredients
      create_recipe_ingredients(recipe: @recipe, ingredients: params[:ingredients])
    end
    
  end
end