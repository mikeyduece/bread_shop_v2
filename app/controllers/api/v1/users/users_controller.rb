module Api
  module V1
    module Users
      class UsersController < ApiController
        include SerializationHelper
        before_action :doorkeeper_authorize!, except: :create

        helper_method :user

        def create
          user = User.create(user_params)
          if user.save
            success_response(options: UserSerializer.new(user))
          else
            render json: 'A user with that email already exists'
          end
        end

        def show
          success_response(options: UserSerializer.new(user))
        end

        private

        def user
          @user = User.find_by(id: params[:user_id] || params[:id])
        end

        def user_params
          params.require(:user).permit(:first_name, :last_name, :email, :password, :phone_number)          
        end
      end
    end
  end    
end