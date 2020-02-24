class Users::UserBlueprint < Blueprinter::Base
  identifier :id
  
  view :normal do
    fields :name, :email_address
  end
  
  view :extended do
    fields :first_name, :last_name, :phone_number
  end
end