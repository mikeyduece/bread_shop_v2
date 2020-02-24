class ApiController < ActionController::API
  include DrySerialization::Blueprinter
  include SerializationHelper

  helper_method :current_api_user
  delegate :t, to: I18n

  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { 
        data: {
          error: "Not Authorized"
        }
      }
    }
  end

  def current_api_user
    @current_api_user ||= User.find_by(id: doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end