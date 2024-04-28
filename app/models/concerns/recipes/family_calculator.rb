# frozen_string_literal: true

module Recipes
  module FamilyCalculator
    private def calculate_family
      if lean?
        update_columns(family_id: set_family(:lean))
      elsif soft?
        update_columns(family_id: set_family(:soft))
      elsif sweet?
        update_columns(family_id: set_family(:sweet))
      elsif rich?
        update_columns(family_id: set_family(:rich))
      elsif slack?
        update_columns(family_id: set_family(:slack))
      else
        update_columns(family_id: set_family(:other))
      end
    end

    # Sets family according to the name passed in
    private def set_family(name)
      Family.find_by(name:).id
    end

    # Boolean checks for for family related percentage/category ranges
    private def lean?
      sweetener_and_fat_percentages.all?(Api::Recipes::LOW) && Api::Recipes::LOW.include?(liquid_fat_percentage)
    end

    private def soft?
      !Api::Recipes::HIGH.include?(sweetener_percentage) && (water_percentage.ceil + liquid_fat_percentage.ceil <= 68.9) &&
      ((Api::Recipes::MODERATE.include?(liquid_fat_percentage) || Api::Recipes::MODERATE.include?(fat_percentage)) ||
        Api::Recipes::MODERATE.include?([fat_percentage, liquid_fat_percentage].sum))
    end

    private def rich?
      (Api::Recipes::MODERATE.include?(sweetener_percentage) && Api::Recipes::HIGH.include?(fat_percentage)) ||
      Api::Recipes::HIGH.include?(fat_percentage)
    end

    private def slack?
      Api::Recipes::MODERATE.include?(liquid_fat_percentage) && (water_percentage >= 69.0 ||
        water_percentage.ceil + liquid_fat_percentage.ceil >= 69.0)
    end

    private def sweet?
      sweetener_and_fat_percentages.all?(Api::Recipes::HIGH)
    end

    # Percentage ranges for calculating families
    private def sweetener_percentage
      sweets = sweetener_amounts || 0
      calculate_percentage(sweets)
    end

    private def fat_percentage
      fats = fat_amounts || 0
      calculate_percentage(fats)
    end

    private def water_percentage
      water = water_amounts || 0
      calculate_percentage(water)
    end

    private def liquid_fat_percentage
      liquid_fats = liquid_fat_amounts || 0
      calculate_percentage(liquid_fats)
    end

    private def sweetener_and_fat_percentages
      [sweetener_percentage, fat_percentage]
    end

    # Calculated category amounts
    private def sweetener_amounts
      sum_recipe_ingredient_amounts[:sweetener]
    end

    private def fat_amounts
      sum_recipe_ingredient_amounts[:fat]
    end

    private def liquid_fat_amounts
      sum_recipe_ingredient_amounts['liquid fat']
    end

    private def water_amounts
      sum_recipe_ingredient_amounts[:water]
    end

    # Helper Methods
    private def sum_recipe_ingredient_amounts
      @sum_recipe_ingredient_amounts ||= recipe_ingredients.amount_totals_by_category
    end

    private def calculate_percentage(category_amount)
      ((category_amount / flour_amounts) * 100).round(2)
    end
  end
end
