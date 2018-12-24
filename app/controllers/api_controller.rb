class ApiController < ActionController::API
  helper_method :current_api_user

  def current_api_user
    @current_api_user ||= User.find_by(id: doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end