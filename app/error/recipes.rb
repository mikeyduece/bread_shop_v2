class BaseError < StandardError
end

module Recipes
  class NoFlourError < BaseError
  end
  
  class InvalidAmountTotals < BaseError
  end
end
