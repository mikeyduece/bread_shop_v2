class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.references :category, foreign_key: true, index: true
      t.string :name, index: true, null: false
      
      t.timestamps
    end

    add_index :ingredients, %i[category_id name]
  end
end
