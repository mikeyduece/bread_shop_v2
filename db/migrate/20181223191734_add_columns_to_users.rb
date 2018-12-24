class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string, index: true, null: false
    add_column :users, :last_name, :string, index: true, null: false
    add_column :users, :phone_number, :string, index: true, null: false
  end
end
