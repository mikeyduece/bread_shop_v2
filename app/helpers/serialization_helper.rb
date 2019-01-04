module SerializationHelper
  def success_response(code: 200, data: {}, message: nil)
    render status: code, json: { message: message }.merge(data)
  end

  def error_response(code: nil, message: nil)
    render status: code, json: { message: message }
  end
end