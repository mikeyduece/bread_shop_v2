module Api
  module RecipeHelper
    LOW = (0.0..4.99)

    MODERATE = (5.0..10.0)

    HIGH = (11.0..25.0)

    def create_recipe(user:, params:)
      recipe = user.recipes.create(params.except(:ingredients))
require 'pry'; binding.pry
      create_recipe_ingredients(recipe: recipe, ingredients: params[:ingredients])
      recipe.recipe_ingredients.find_each(&:save)
      recipe.calculate_family
      recipe
    end

    def update_recipe(user:, ingredients:)
      ingredients.each do |ingredient|
        ing = Ingredient.find_by(name: ingredient[:name].downcase)

        recipe_ingredient = recipe_ingredients.find_or_create_by(ingredient: ing, amount: ingredient[:amount])
        recipe_ingredient.update_attributes(amount: ingredient[:amount])
      end
    end

    private

    def create_recipe_ingredients(recipe:, ingredients:)
      ingredients.each do |ingredient|
        ing = Ingredient.find_or_create_by(name: ingredient[:name].downcase)

        recipe.recipe_ingredients.create(amount: ingredient[:amount], ingredient: ing)
      end
    end
  end
end