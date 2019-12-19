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

    def lean?
      sweet_and_fat_amts.all? { |amt| Api::Recipes::LOW.include?(amt) }
    end
  
    def soft?
      (water_percentage + fat_percentage) < 70.0 &&
          Api::Recipes::MODERATE.include?(sweetener_percentage) &&
          Api::Recipes::MODERATE.include?(fat_percentage)
    end
  
    def rich?
      (Api::Recipes::MODERATE.include?(sweetener_percentage) &&
          Api::Recipes::HIGH.include?(fat_percentage)) ||
          Api::Recipes::HIGH.include?(fat_percentage)
    end
  
    def slack?
      water_percentage + fat_percentage > 70.0
    end
  
    def sweet?
      sweet_and_fat_amts.all? { |amt| Api::Recipes::HIGH.include?(amt) }
    end

    def family_assignment(name)
      Family.find_by(name: name)&.id
    end
  
    def sum_recipe_ingredient_amounts(category_name)
      category = Category.find_by(name: category_name)
      recipe_ingredients.includes(:ingredient)
        .where(ingredients: { category_id: category.id })
        .sum(:amount)
    end
  
    def destroy_all_recipe_ingredients
      recipe_ingredients.delete_all
    end
  
    def sweetener_percentage
      sweets = sweetener_amounts
      calculate_percentage(sweets)
    end
  
    def fat_percentage
      fats = fat_amounts
      calculate_percentage(fats)
    end
  
    def water_percentage
      water = water_amt
      calculate_percentage(water)
    end
  
    def sweet_and_fat_amts
      [sweetener_percentage, fat_percentage]
    end
  
    def calculate_percentage(category_amount)
      ((category_amount / flour_amts) * 100).round(2)
    end
  
    def flour_amts
      sum_recipe_ingredient_amounts(:flour)
    end
  
    def sweetener_amounts
      sum_recipe_ingredient_amounts(:sweetener)
    end
  
    def fat_amounts
      sum_recipe_ingredient_amounts(:fat)
    end
  
    def water_amt
      sum_recipe_ingredient_amounts(:water)
    end
  
    def calculate_family
      case
      when lean? then update_attributes(family_id: family_assignment(:lean))
      when soft? then update_attributes(family_id: family_assignment(:soft))
      when sweet? then update_attributes(family_id: family_assignment(:sweet))
      when rich? then update_attributes(family_id: family_assignment(:rich))
      when slack? then update_attributes(family_id: family_assignment(:slack))
      end
    end

    def new_flour_total(new_dough_weight:)
      ((new_dough_weight.to_f / total_percentage.to_f) * 100).round(2)
    end

    def recalculated_amounts(new_flour_weight:)
      recipe_ingredients.includes(:ingredient).find_each do |recipe_ingredient|
        ingredient = recipe_ingredient.ingredient
        new_amount = (new_flour_weight * (recipe_ingredient.bakers_percentage.to_f / 100)).round(2)
        
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