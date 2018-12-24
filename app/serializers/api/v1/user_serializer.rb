module Api
  module V1
    class UserSerializer
      include FastJsonapi::ObjectSerializer
      set_key_transform :camel_lower
      attributes :id, :email, :phone_number
    
      attribute :name do |object|
        "#{object.first_name} #{object.last_name}"
      end
    end
  end
end