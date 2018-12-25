class AddBakersPercentageToRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :recipe_ingredients, :bakers_percentage, :float, index: true
  end
end
