class ApiController < ActionController::API
  include Auth0CurrentUser::Secured
  include DrySerialization::Blueprinter
  include DrySerialization::Concerns::SerializationHelper
  
  delegate :t, to: I18n
  
  rescue_from JWT::VerificationError, JWT::DecodeError do |exception|
    render json: { errors: ['Not Authenticated', exception], status: :unauthorized }
  end
  
end
