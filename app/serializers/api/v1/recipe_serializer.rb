class Api::V1::RecipeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :ingredients
end
