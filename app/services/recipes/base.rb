module Recipes
  class Base
    attr_reader :user, :params
    
    def self.call(user, params = nil, &block)
      new(user, params).call(&block)
    end
    
    def initialize(user, params)
      @params = params
      @user   = user
    end
    
    private_class_method :new
    
    def call(&block)
      raise NotImplementedError
    end
  
  end
end