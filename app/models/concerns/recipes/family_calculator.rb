module Recipes
  module FamilyCalculator
    private
    
    def calculate_family
      case
        when lean?
          update_columns(family_id: set_family(:lean))
        when soft?
          update_columns(family_id: set_family(:soft))
        when sweet?
          update_columns(family_id: set_family(:sweet))
        when rich?
          update_columns(family_id: set_family(:rich))
        when slack?
          update_columns(family_id: set_family(:slack))
        else
          update_columns(family_id: set_family(:other))
      end
    end
    
    # Sets family according to the name passed in
    def set_family(name)
      Family.find_by(name: name).id
    end
    
    # Boolean checks for for family related percentage/category ranges
    def lean?
      sweetener_and_fat_percentages.all?(Api::Recipes::LOW) && Api::Recipes::LOW.include?(liquid_fat_percentage)
    end
    
    def soft?
      !Api::Recipes::HIGH.include?(sweetener_percentage) && (water_percentage.ceil + liquid_fat_percentage.ceil <= 68.9) &&
      ((Api::Recipes::MODERATE.include?(liquid_fat_percentage) || Api::Recipes::MODERATE.include?(fat_percentage)) || Api::Recipes::MODERATE.include?([fat_percentage, liquid_fat_percentage].sum))
    end
    
    def rich?
      (Api::Recipes::MODERATE.include?(sweetener_percentage) && Api::Recipes::HIGH.include?(fat_percentage)) ||
        Api::Recipes::HIGH.include?(fat_percentage)
    end
    
    def slack?
      Api::Recipes::MODERATE.include?(liquid_fat_percentage) && (water_percentage >= 69.0 ||
        water_percentage.ceil + liquid_fat_percentage.ceil >= 69.0)
    end
    
    def sweet?
      sweetener_and_fat_percentages.all?(Api::Recipes::HIGH)
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
      water = water_amounts || 0
      calculate_percentage(water)
    end
    
    def liquid_fat_percentage
      liquid_fats = liquid_fat_amounts || 0
      calculate_percentage(liquid_fats)
    end
    
    def sweetener_and_fat_percentages
      [sweetener_percentage, fat_percentage]
    end
    
    # Calculated category amounts
    def sweetener_amounts
      sum_recipe_ingredient_amounts[:sweetener]
    end
    
    def fat_amounts
      sum_recipe_ingredient_amounts[:fat]
    end
    
    def liquid_fat_amounts
      sum_recipe_ingredient_amounts['liquid fat']
    end
    
    def water_amounts
      sum_recipe_ingredient_amounts[:water]
    end
    
    # Helper Methods
    def sum_recipe_ingredient_amounts
      @totals ||= recipe_ingredients.amount_totals_by_category
    end
    
    def calculate_percentage(category_amount)
      ((category_amount / flour_amounts) * 100).round(2)
    end
  
  end
end