class ApiController < ActionController::API
  include Auth0CurrentUser::Secured
  include DrySerialization::FastJsonapi
  include DrySerialization::Concerns::SerializationHelper
  
  delegate :t, to: I18n
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from JWT::VerificationError, JWT::DecodeError do |exception|
    error_response(['Not Authenticated', exception.message], status: :unauthorized)
  end
  
  private
  
  def not_found
    error_response('Not Found', :not_found)
  end
  
end
