module Recipes
  module FamilyCalculator
    
    # Boolean checks for for family related percentage/category ranges
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
    
    # Percentage ranges for calculating families
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
    
    # Calculated category amounts
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

    def set_family(name)
      Family.find_by(name: name)
    end
    
    def calculate_family
      case
        when lean?
          update_attributes(family: set_family(:lean))
        when soft?
          update_attributes(family: set_family(:soft))
        when sweet?
          update_attributes(family: set_family(:sweet))
        when rich?
          update_attributes(family: set_family(:rich))
        when slack?
          update_attributes(family: set_family(:slack))
      end
    end
    
    private
    
    # Helper Methods
    def sum_recipe_ingredient_amounts(category_name)
      category = Category.find_by(name: category_name)
      recipe_ingredients.includes(:ingredient)
                        .where(ingredients: { category_id: category.id })
                        .sum(:amount)
    end

    def calculate_percentage(category_amount)
      raise Recipes::NoFlourError if flour_amts < 1
      
      ((category_amount / flour_amts) * 100).round(2)
    end
  
  end
end