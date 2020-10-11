module Recipes
  class BaseRecipeService < BaseService
    attr_reader :user, :params
    
    def initialize(user: nil, params:)
      @params = params
      @user = user
    end
    
    private_class_method :new
    
    private
    
    def recipe
      @recipe ||= Recipe.find(params.dig(:data, :id))
    end
    
    def build_recipe_ingredients(ingredients:)
      recipe_ingredients_attributes = ingredients.each_with_object({}) do |recipe_ingredient, acc|
        attrs = attributes(recipe_ingredient)
        ingredient_id = Ingredient.find_or_create_by(name: attrs[:name].downcase).id
        
        acc[attrs[:name]] ||= { amount: attrs[:amount], ingredient_id: ingredient_id }
      end.values
      raise_error_if_required(recipe_ingredients_attributes)
      
      { recipe_ingredients_attributes: recipe_ingredients_attributes }
    end
    
    def raise_error_if_required(attributes)
      total = attributes.sum { |(k,_v)| k[:amount] }
      recipe_total = recipe.number_of_portions * recipe.weight_per_portion
      
      unless ((recipe_total - 2)..recipe_total + 2).include?(total.round)
        raise Recipes::InvalidAmountTotalsError, I18n.t('api.errors.recipes.invalid_amount_totals')
      end
    end
  
  end
end