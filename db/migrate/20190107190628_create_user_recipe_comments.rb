class CreateUserRecipeComments < ActiveRecord::Migration[5.2]
  def change
    create_table :user_recipe_comments do |t|
      t.references :user, foreign_key: true
      t.references :recipe, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
