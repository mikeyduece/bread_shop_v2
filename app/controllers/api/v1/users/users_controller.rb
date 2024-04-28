# frozen_string_literal: true

module Api
  module V1
    module Users
      class UsersController < UsersBaseController
        skip_before_action :set_user, only: :create

        def create
          service = ::Users::CreateService.call(params: user_params)
          return error_response(service.errors.full_messages, :unprocessable_entity) unless service.success?

          success_response(serialized_resource(service.user, UserSerializer), :created)
        end

        def show
          success_response(serialized_resource(@user, UserSerializer, view: :extended))
        end

        def update
          if current_user.update!(user_params)
            success_response(serialized_resource(current_user, UserSerializer))
          else
            error_response(current_user.errors.full_messages, :unprocessable_entity)
          end
        end

        private def user_params
          params.permit(
            data: [
              :type,
              { attributes: %i[first_name last_name email phone_number] }
            ]
          )
        end
      end
    end
  end
end
