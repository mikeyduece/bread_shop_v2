class ChangeUsersPhoneColumnNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :phone_number, true
  end
end
