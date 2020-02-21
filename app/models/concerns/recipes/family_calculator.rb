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
      sweets = sweetener_amounts || 0
      calculate_percentage(sweets)
    end
    
    def fat_percentage
      fats = fat_amounts || 0
      calculate_percentage(fats)
    end
    
    def water_percentage
      water = water_amt || 0
      calculate_percentage(water)
    end
    
    def sweet_and_fat_amts
      [sweetener_percentage, fat_percentage]
    end
    
    # Calculated category amounts
    def flour_amts
      flour = sum_recipe_ingredient_amounts[:flour]
      raise Recipes::NoFlourError if flour < 1
      
      flour
    end
    
    def sweetener_amounts
      sum_recipe_ingredient_amounts[:sweetener]
    end
    
    def fat_amounts
      sum_recipe_ingredient_amounts[:fat]
    end
    
    def water_amt
      sum_recipe_ingredient_amounts[:water]
    end

    def set_family(name)
      Family.find_by(name: name)
    end
    
    def calculate_family
      case
        when lean?
          update(family: set_family(:lean))
        when soft?
          update(family: set_family(:soft))
        when sweet?
          update(family: set_family(:sweet))
        when rich?
          update(family: set_family(:rich))
        when slack?
          update(family: set_family(:slack))
      end
    end
    
    private
    
    # Helper Method
    # TODO: This might be better suited as a scope in rec ing
    def sum_recipe_ingredient_amounts
      @totals ||= recipe_ingredients.amount_totals_by_category
    end

    def calculate_percentage(category_amount)
      ((category_amount / flour_amts) * 100).round(2)
    end
  
  end
end