module SerializationHelper
  def success_response(code: 200, options:, message: nil)
    render json: { code: code, message: message }.merge(options)
  end

  def error_response(code: nil, message: nil)
    render json: { code: code, message: message }
  end
end