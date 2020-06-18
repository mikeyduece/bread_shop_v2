module Api
  module RecipeHelper
    def create_recipe(user:, params:)
      recipe = user.recipes.create(params.except(:ingredients))

      create_recipe_ingredients(recipe: recipe, ingredients: params[:ingredients])
      recipe.recipe_ingredients.find_each(&:save)
      recipe.calculate_family
      recipe
    end

    def update_recipe(params:)
      recipe_ingredients.destroy_all
      update_attributes(number_of_portions: params[:number_of_portions], weight_per_portion: params[:weight_per_portion], units: params[:units])
      create_recipe_ingredients(recipe: self, ingredients: params[:ingredients])
      recipe_ingredients.find_each(&:save)
    end

    

   
  
    def destroy_all_recipe_ingredients
      recipe_ingredients.delete_all
    end
  
  

 

    def recalculated_amounts(new_flour_weight:)
      recipe_ingredients.includes(:ingredient).find_each do |recipe_ingredient|
        ingredient = recipe_ingredient.ingredient
        new_amount = (new_flour_weight * (recipe_ingredient.bakers_percentage.to_f / 100)).round(2)
        
      end
    end

    private


  end
end