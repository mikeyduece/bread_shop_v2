module Recipes
  class Create < BaseRecipeService
    
    def call
      Success.new(recipe: recipe)
    rescue ActiveRecord::RecordNotUnique => e
      yield(NoTrigger, Failure.new(error: I18n.t('api.errors.recipes.record_exists'), status: :unprocessable_entity))
    rescue StandardError => e
      yield(NoTrigger, Failure.new(error: e.message, status: :unprocessable_entity))
    end
    
    private
    
    def recipe
      @recipe ||= user.recipes.build(params.except(:ingredients))
      add_ingredients
      @recipe
    end
    
    def add_ingredients
      create_recipe_ingredients(recipe: @recipe, ingredients: params[:ingredients])
    end
  
  end
end