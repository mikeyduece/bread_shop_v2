class RecipeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :weight_per_portion, :number_of_portions, :unit, :formatted_ingredients
  
  has_many :recipe_ingredients, serializer: RecipeIngredientSerializer
  has_many :tags, serializer: TagSerializer
  
end
