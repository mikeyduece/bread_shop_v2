class AddIndexToRecipeIngredientsColumns < ActiveRecord::Migration[5.2]
  def change
    add_index :recipe_ingredients, :amount
    add_index :recipe_ingredients, :bakers_percentage
  end
end
