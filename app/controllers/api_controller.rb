class ApiController < ActionController::API
  include Auth0CurrentUser::Secured
  include DrySerialization::Blueprinter
  include DrySerialization::Concerns::SerializationHelper
  
  delegate :t, to: I18n
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from JWT::VerificationError, JWT::DecodeError do |exception|
    render json: { errors: ['Not Authenticated', exception], status: :unauthorized }
  end
  
  private
  
  def not_found
    error_response('Not Found', :not_found)
  end
  
end
