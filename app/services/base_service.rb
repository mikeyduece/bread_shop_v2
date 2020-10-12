class BaseService
  include Callable
  
  class Success < OpenStruct
    def success?
      true
    end
    
    def error
    end
  end
  
  class Failure < OpenStruct
    def success?
      false
    end
  end
  
  
  private
  
  def handle_error(error)
    Rails.logger.error(error.message)
    Rails.logger.error(error.backtrace)
    Failure.new(errors: error.message)
  end
  
  def attribute(base, attribute)
    base.dig(:data, :attributes, attribute)
  end
  
  def attributes(base_params)
    parse_serialization(base_params, :attributes)
  end
  
  def relationships(base_params)
    parse_serialization(base_params, :relationships)
  end
  
  def parse_serialization(base_params, key)
    base_params.dig(:data, key.to_sym)
  end
  
  def relationship(base_params, rel_name)
    rel = relationships(base_params)
    rel[rel_name]
  end
  
  def inclusions(base_params)
    base_params.dig(:included)
  end

end