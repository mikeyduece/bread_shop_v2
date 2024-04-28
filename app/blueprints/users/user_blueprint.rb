# frozen_string_literal: true

module Users
  class UserBlueprint < BaseBlueprint
    identifier :id

    view :normal do
      fields :name, :email_address
    end

    view :extended do
      fields :first_name, :last_name, :phone_number
    end
  end
end
