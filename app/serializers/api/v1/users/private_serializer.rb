module Api
  module V1
    module Users
      class PrivateSerializer < OverviewSerializer
        attributes :email, :phone_number
      end
    end
  end
end