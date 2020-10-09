module Recipes
  class BaseRecipeService < BaseService
    attr_reader :user, :params
    
    def initialize(user:, params:)
      @params = params
      @user = user
    end
    
    private_class_method :new
    
    def build_recipe_ingredients(ingredients:)
      recipe_ingredients_attributes = ingredients.each_with_object({}) do |recipe_ingredient, acc|
        attrs = attributes(recipe_ingredient)
        ingredient_id = Ingredient.find_or_create_by(name: attrs[:name].downcase).id
        
        acc[attrs[:name]] ||= { amount: attrs[:amount], ingredient_id: ingredient_id }
      end.values
      
      { recipe_ingredients_attributes: recipe_ingredients_attributes }
    end
  
  end
end