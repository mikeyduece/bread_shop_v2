# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.references :user, foreign_key: true, index: true
      t.references :family, foreign_key: true, index: true
      t.integer :unit, index: true, null: false, default: 0
      t.string :name, index: true, null: false
      t.integer :number_of_portions, null: false
      t.float :weight_per_portion, null: false

      t.timestamps
    end

    add_index :recipes, %i[user_id name family_id], unique: true
    add_index :recipes, %i[user_id name], unique: true
  end
end
