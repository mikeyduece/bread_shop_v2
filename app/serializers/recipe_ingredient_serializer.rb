class RecipeIngredientSerializer
  include FastJsonapi::ObjectSerializer
  attributes :amount, :bakers_percentage
  
  belongs_to :ingredient, serializer: IngredientSerializer
  
end
