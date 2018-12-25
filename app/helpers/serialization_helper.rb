module SerializationHelper
  def success_response(code: 200, data: {}, message: nil)
    render json: { code: code, message: message }.merge(data)
  end

  def error_response(code: nil, message: nil)
    render json: { code: code, message: message }
  end
end