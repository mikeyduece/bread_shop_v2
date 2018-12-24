class AddIndexToTables < ActiveRecord::Migration[5.2]
  def change
    add_index :families, :name
    add_index :recipes, :name
  end
end
