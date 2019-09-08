class CreateRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_ingredients do |t|
      t.references :recipe, foreign_key: true, index: true
      t.references :ingredient, foreign_key: true, index: true
      t.float :amount, null: false
      t.float :bakers_percentage, null: false

      t.timestamps
    end

    add_index :recipe_ingredients, %i[recipe_id ingredient_id]
  end
end
