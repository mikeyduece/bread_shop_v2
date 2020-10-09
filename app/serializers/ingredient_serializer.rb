class IngredientSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  
  belongs_to :category
end
