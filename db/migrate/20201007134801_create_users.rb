class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, unique: true, null: false, index: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone_number
      
      t.timestamps
    end
  end
end
