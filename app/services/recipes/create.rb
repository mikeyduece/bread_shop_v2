module Recipes
  class Create < BaseRecipeService
    
    def call
      build_recipe!
      Success.new(recipe: recipe)
    rescue ActiveRecord::RecordNotUnique => e
      Failure.new(error: I18n.t('api.errors.recipes.record_exists'))
    rescue StandardError => e
      Failure.new(error: e.message)
    end
    
    private
    
    attr_accessor :recipe
    
    def build_recipe!
      attrs = attributes(params)
      @recipe ||= user.recipes.build(attrs)
      add_ingredients!
    end
    
    def add_ingredients!
      attrs = relationship(params, :ingredients)
      create_recipe_ingredients(recipe: recipe, ingredients: attrs)
    end
  
  end
end