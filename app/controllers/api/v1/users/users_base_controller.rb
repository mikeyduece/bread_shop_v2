# frozen_string_literal: true

module Api
  module V1
    module Users
      class UsersBaseController < ApiController
        before_action :set_user

        def set_user
          @user = if (params[:user_id].eql?('me') || params[:id].eql?('me')) && current_user
                    current_user
                  else
                    User.find(params[:user_id] || params[:id])
                  end
        end
      end
    end
  end
end
