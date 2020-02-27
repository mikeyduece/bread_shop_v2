class CreateForumTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :forum_topics do |t|
      t.references :forum, index: true, null: false
      t.references :owner, polymorphic: true
      t.string :title, null: false, index: true
      
      t.timestamps
    end
    
    add_index :forum_topics, %i[owner_id owner_type title], unique: true
    add_index :forum_topics, %i[forum_id owner_id owner_type title], unique: true, name: :idx_forum_topics_on_forum_owner_title
  end
end
