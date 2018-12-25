class Api::V1::RecipeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :total_percentage, :units, :ingredients

  attribute :total_percentage do |object|
    "#{object.total_percentage}%"
  end
end
