module SerializationHelper
  def success_response(code = 200, data = {}, message = nil)
    default_response = default_response(code, message, data)
    render json: default_response
  end
  
  def error_response(message, code = 200)
    default_response = default_response(code, message, nil)
    render json: default_response
  end

  def default_response(code, message, data)
    { code: code, message: message }.merge(data)
  end


  #def serialized_resource(resource, serializer, options = {})
  #  return nil if resource.nil?
  #
  #  options[:serializer] = serializer
  #  if resource.is_a?(Array) || resource.is_a?(::ActiveRecord::Relation)
  #    ::ActiveModel::Serializers::CollectionSerializer.new(resource, options)
  #  else
  #    ::ActiveModel::Serializers::SerializableResource.new(resource, options)
  #  end
  #end
end