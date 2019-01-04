module Api
  module V1
    module Users
      class UsersController < ApiController
        before_action :doorkeeper_authorize!, except: :create

        def create
          user = User.create(user_params)
          if user.save
            success_response(code: 204, data: Users::PrivateSerializer.new(user))
          else
            render json: 'A user with that email already exists'
          end
        end

        def show
          success_response(data: Users::PrivateSerializer.new(current_api_user))
        end

        def update
          if current_api_user.update(user_params)
            success_response(data: Users::PrivateSerializer.new(current_api_user))
          end
        end

        private

        def user_params
          params.require(:user).permit(:first_name, :last_name, :email, :password, :phone_number)          
        end
      end
    end
  end    
end