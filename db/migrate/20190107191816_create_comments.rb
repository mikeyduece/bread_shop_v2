class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :owner, polymorphic: true, index: true
      t.references :commentable, polymorphic: true, index: true
      t.references :parent
      t.text :body

      t.timestamps
    end

    add_index :comments, %i[owner_id owner_type]
    add_index :comments, %i[commentable_id commentable_type]
    add_index :comments, %i[commentable_id owner_id commentable_type owner_type], name: :index_comments_on_owner_and_commentable
  end
end
