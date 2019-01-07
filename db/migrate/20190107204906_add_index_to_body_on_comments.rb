class AddIndexToBodyOnComments < ActiveRecord::Migration[5.2]
  def change
    add_index :comments, :body
  end
end
