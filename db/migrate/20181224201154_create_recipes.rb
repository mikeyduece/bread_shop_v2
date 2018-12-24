class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :number_of_portions
      t.float :weight_per_portion
      t.references :user, foreign_key: true
      t.references :family, foreign_key: true

      t.timestamps
    end
  end
end
