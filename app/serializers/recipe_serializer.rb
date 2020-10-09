class RecipeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :weight_per_portion, :number_of_portions, :unit
  
  has_many :recipe_ingredients, serializer: RecipeIngredientSerializer
end
