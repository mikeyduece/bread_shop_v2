module Api
  module V1
    module Users
      class UsersController < ApiController
        include SerializationHelper
        before_action :doorkeeper_authorize!, except: :create

        def create
          user = User.create(user_params)
          if user.save
            success_response(code: 204, options: UserSerializer.new(user))
          else
            render json: 'A user with that email already exists'
          end
        end

        def show
          success_response(options: UserSerializer.new(current_api_user))
        end

        private

        def user_params
          params.require(:user).permit(:first_name, :last_name, :email, :password, :phone_number)          
        end
      end
    end
  end    
end