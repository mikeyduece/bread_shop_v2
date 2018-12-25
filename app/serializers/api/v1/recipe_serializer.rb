class Api::V1::RecipeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :total_percentage, :ingredients

  attribute :total_percentage do |object|
    "#{object.total_percentage}%"
  end
end
