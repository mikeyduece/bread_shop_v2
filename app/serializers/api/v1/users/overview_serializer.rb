module Api
  module V1
    module Users
      class OverviewSerializer
        include FastJsonapi::ObjectSerializer
        set_key_transform :camel_lower
      
        attribute :name do |object|
          "#{object.first_name} #{object.last_name}"
        end
      end
    end
  end
end
