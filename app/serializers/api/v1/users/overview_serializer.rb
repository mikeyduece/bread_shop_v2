module Api
  module V1
    module Users
      class OverviewSerializer < BaseSerializer
        attribute :name do |object|
          "#{object.first_name} #{object.last_name}"
        end
      end
    end
  end
end
