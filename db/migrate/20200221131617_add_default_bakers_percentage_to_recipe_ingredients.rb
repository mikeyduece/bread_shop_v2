class AddDefaultBakersPercentageToRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        change_column_default :recipe_ingredients, :bakers_percentage, 0.0
        change_column_default :recipe_ingredients, :amount, 0.0
      end
      
      dir.down do
        change_column_default :recipe_ingredients, :bakers_percentage, 0.0
        change_column_default :recipe_ingredients, :amount, 0.0
      end
    end
  end
end
