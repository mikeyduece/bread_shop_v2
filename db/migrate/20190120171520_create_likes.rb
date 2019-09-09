class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true
      t.references :owner, polymorphic: true

      t.timestamps
    end
  end
end
