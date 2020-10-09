module Recipes
  class BaseRecipeService < BaseService
    attr_reader :user, :params
    
    def initialize(user:, params:)
      @params = params
      @user   = user
    end
    
    private_class_method :new
    
    def create_recipe_ingredients(recipe:, ingredients:)
      ingredients.each do |ingredient|
        attrs = attributes(ingredient)
        ingredient_object = Ingredient.find_or_create_by(name: attrs[:name].downcase)
        
        recipe.recipe_ingredients.build(amount: attrs[:amount], ingredient: ingredient_object)
      end
      recipe.save
    end
  
  end
end