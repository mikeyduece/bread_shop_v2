class Api::V1::RecipeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :total_percentage, :units, :ingredients
  belongs_to :family
  belongs_to :user

  attribute :total_percentage do |object|
    "#{object.total_percentage}%"
  end
end
