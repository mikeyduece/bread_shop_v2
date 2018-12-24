module SerializationHelper
  def success_response(code: 200, options:, message: nil)
    render json: { code: code, message: message }.merge(options)
  end
end