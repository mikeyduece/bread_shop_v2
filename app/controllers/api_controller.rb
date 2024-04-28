# frozen_string_literal: true

class ApiController < ActionController::API
  include Auth0CurrentUser::Secured
  include DrySerialization::JsonapiSerializer
  include DrySerialization::Concerns::SerializationHelper
  include DrySerialization::Concerns::Deserializable

  before_action :set_response_headers

  delegate :t, to: I18n
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from JWT::VerificationError, JWT::DecodeError do |exception|
    error_response(['Not Authenticated', exception.message], status: :unauthorized)
  end

  def limit
    params[:limit] ||= 10
  end

  def offset
    params[:offset] ||= 0
  end

  private def set_response_headers
    response.set_header('Content-Type', 'application/vnd.breadshop.json; version=1')
  end

  private def not_found
    error_response('Not Found', :not_found)
  end
end
