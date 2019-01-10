class AddUserToForums < ActiveRecord::Migration[5.2]
  def change
    add_reference :forums, :user, foreign_key: true
  end
end
