module Recipes
  class Base
    include SerializationHelper
    attr_reader :user, :params
    
    def self.call(user, params = nil, &block)
      new(user, params).call(&block)
    end
    
    def initialize(user, params)
      @params = params[:recipe]
      @user   = user
    end
    
    private_class_method :new
    
    def call(&block)
      raise NotImplementedError
    end

    def create_recipe_ingredients(recipe:, ingredients:)
      ingredients.each do |ingredient|
        ingredient_object = Ingredient.find_or_create_by(name: ingredient[:name].downcase)
    
        recipe.recipe_ingredients.build(amount: ingredient[:amount], ingredient: ingredient_object)
      end
    end
    
  end
end