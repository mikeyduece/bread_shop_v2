# frozen_string_literal: true

class RemoveColumnNullOnRecipeIngredientsBakersPercentage < ActiveRecord::Migration[6.0]
  def change
    change_column_null :recipe_ingredients, :bakers_percentage, true
  end
end
