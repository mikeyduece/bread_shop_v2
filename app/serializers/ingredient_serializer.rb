# frozen_string_literal: true

class IngredientSerializer
  include JSONAPI::Serializer
  attributes :name

  belongs_to :category
end
