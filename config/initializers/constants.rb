module Api
  module Recipes
    LOW = (0.0..4.99)
    MODERATE = (5.0..15)
    HIGH = (15.1..100.0)
  end

  module Ingredients
    SWEETENERS = %w[
      sugar brown\ sugar corn\ syrup
      agave molasses honey maple\ syrup stevia
    ].freeze

    FATS = %w[butter cream sour\ cream margerine shortening].freeze
    
    TENDERIZERS = %w[egg].freeze
    
    LIQUID_FATS = %w[olive\ oil canola\ oil]

    WATER = %w[water milk].freeze

    FLOURS = %w[
      flour bread\ flour high\ gluten\ flour ap\ flour all\ purpose\ flour
      spelt wheat\ flour whole\ wheat\ flour cake\ flour pastry\ flour semolina
      durum corn\ meal flax\ meal cornmeal
    ].freeze
  end
end