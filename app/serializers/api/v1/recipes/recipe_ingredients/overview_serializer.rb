class Api::V1::Recipes::RecipeIngredients::OverviewSerializer < BaseSerializer
  attributes :amount, :bakers_percentage
  
  attribute :ingredient do |object|
    BASE::Ingredients::OverviewSerializer.new(object.ingredient)
  end
end
