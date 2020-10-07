module Api
  module V1
    module Users
      class UsersController < UsersBaseController
        skip_before_action :set_user, only: :create
        
        def create
          user = User.create(user_params)
          if user.save
            success_response(user: serialized_resource(user, ::Users::UserBlueprint, view: :extended), status: :created)
          else
            error_response('A user with that email already exists', 404)
          end
        end

        def show
          success_response(user: serialized_resource(@user, ::Users::UserBlueprint, view: :extended))
        end

        def update
          if current_user.update(user_params)
            success_response(data: Users::PrivateSerializer.new(current_user))
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