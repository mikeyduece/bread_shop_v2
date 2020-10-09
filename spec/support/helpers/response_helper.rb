module ResponseHelper
  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def attributes(attribute)
    json_response.dig(:data, :attributes, attribute)
  end
  
  def relationships(rel_name)
    json_response.dig(:data, :relationships, rel_name)
  end
  
  def included(rel_type)
    json_response.dig(:included).select { |h| h[:type].eql?(rel_type.to_s) }
  end
  
end