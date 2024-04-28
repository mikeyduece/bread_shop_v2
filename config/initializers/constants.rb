# frozen_string_literal: true

module Api
  module Recipes
    LOW = (0.0..4.99).freeze
    MODERATE = (5.0..15).freeze
    HIGH = (15.1..100.0).freeze
  end

  module Ingredients
    SWEETENERS = [
      'sugar', 'brown sugar', 'corn syrup', 'agave', 'molasses', 'honey', 'maple syrup', 'stevia'
    ].freeze

    FATS = ['butter', 'cream', 'sour cream', 'margerine', 'shortening'].freeze

    TENDERIZERS = %w[egg].freeze

    LIQUID_FATS = ['olive oil', 'canola oil'].freeze

    WATER = %w[water milk].freeze

    FLOURS = [
      'flour', 'bread flour', 'high gluten flour', 'ap flour', 'all purpose flour', 'spelt', 'wheat flour', 'whole wheat flour', 'cake flour', 'pastry flour', 'semolina', 'durum', 'corn meal', 'flax meal', 'cornmeal'
    ].freeze
  end
end
