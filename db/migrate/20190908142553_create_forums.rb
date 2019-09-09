class CreateForums < ActiveRecord::Migration[5.2]
  def change
    create_table :forums do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
    end
  end
end
