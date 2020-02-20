module Recipes
  class Create < ::Recipes::Base
  
    def call(&block)
      yield(Success.new(recipe), NoTrigger)
      
    rescue StandardError => e
      yield(Failure.new(I18n.t('api.errors.record_exists'), 500))
    end
    
  end
end