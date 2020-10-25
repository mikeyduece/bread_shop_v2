class RecipeIngredientSerializer
 include JSONAPI::Serializer
  attributes :amount, :bakers_percentage
  
  belongs_to :ingredient, serializer: IngredientSerializer
  
end
