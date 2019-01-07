class AddUnitsToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :units, :string, index: true, default: "oz"
  end
end
