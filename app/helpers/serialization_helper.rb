module SerializationHelper
  def success_response(code: 200, data: {}, message: nil)
    render status: code, json: { message: message }.merge(data)
  end

  def default_response(code, message, data)
    { code: code, message: message, data: data.as_json }
  end
  
  def error_response(message, status = 0)
    default_response = default_response(status, message, nil)
    render json: default_response, status: status
  end
  
  def serialized_resource(resource, serializer, options = {})
    return nil if resource.nil?
    
    options[:serializer] = serializer
    if resource.is_a?(Array) || resource.is_a?(::ActiveRecord::Relation)
      ::ActiveModel::Serializers::CollectionSerializer.new(resource, options)
    else
      ::ActiveModel::Serializers::SerializableResource.new(resource, options)
    end
  end
end