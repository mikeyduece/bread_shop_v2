# frozen_string_literal: true

class BaseService
  include Callable

  class Success < OpenStruct
    def success?
      true
    end

    def error; end
  end

  class Failure < OpenStruct
    def success?
      false
    end
  end

  private def handle_error(error)
    Rails.logger.error(error.message)
    puts e.backtrace.join("\n\t")
    Failure.new(errors: error.message)
  end

  private def attribute(base, attribute)
    base.dig(:data, :attributes, attribute)
  end

  private def attributes(base_params)
    parse_serialization(base_params, :attributes)
  end

  private def relationships(base_params)
    parse_serialization(base_params, :relationships)
  end

  private def parse_serialization(base_params, key)
    base_params.dig(:data, key.to_sym) || base_params[key.to_sym]
  end

  private def relationship(base_params, rel_name)
    rel = relationships(base_params)
    rel[rel_name]
  end

  private def inclusions(base_params)
    base_params[:included]
  end
end
