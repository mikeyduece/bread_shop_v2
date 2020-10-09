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
      @recipe.save!
    end
    
    def add_ingredients!
      attrs = relationship(params, :ingredients)
      ingredient_attrs = build_recipe_ingredients(ingredients: attrs)
      @recipe.assign_attributes(ingredient_attrs)
    end
  
  end
end