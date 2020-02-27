class ChangeForumStructure < ActiveRecord::Migration[6.0]
  def change
    remove_reference :forums, :user
    remove_column :forums, :body, :text
    
    change_table :forums do |t|
      t.references :admin, index: true, null: false
    end
  end
end
