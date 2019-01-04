class AddNullConstraintsToRecipes < ActiveRecord::Migration[5.2]
  def change
    change_column :recipes, :number_of_portions, :integer, null: false
    change_column :recipes, :weight_per_portion, :float, null: false
    change_column :recipes, :name, :string, null: false
  end
end
