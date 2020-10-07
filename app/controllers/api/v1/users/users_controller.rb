module Api
  module V1
    module Users
      class UsersController < UsersBaseController
        skip_before_action :set_user, only: :create
        
        def create
          user = User.create(user_params)
          if user.save
            success_response(serialized_resource(user, ::Users::UserBlueprint, view: :extended), :created)
          else
            error_response(user.errors.full_messages, :unprocessable_entity)
          end
        end

        def show
          success_response(serialized_resource(@user, ::Users::UserBlueprint, view: :extended))
        end

        def update
          if current_user.update(user_params)
            success_response(serialized_resource(current_user, UserSerializer))
          else
            error_response(current_user.errors.full_messages, :unprocessable_entity)
          end
        end

        private

        def user_params
          params.require(:user).permit(:first_name, :last_name, :email, :phone_number)
        end
      end
    end
  end    
end