module SerializationHelper
  def success_response(status = 200, data = {}, message = nil)
    default_response = default_response(status, message, data)
    render json: default_response
  end
  
  def error_response(message, status = 404)
    default_response = default_response(status, message, nil)
    render json: default_response
  end

  def default_response(status, message, data)
    { status: status, message: message }.merge(data)
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