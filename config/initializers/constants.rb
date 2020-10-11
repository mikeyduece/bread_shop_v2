module Api
  module Recipes
    LOW = (0.0..4.99)
    MODERATE = (5.0..10.99)
    HIGH = (11.0..25.0)
  end

  module Ingredients
    SWEETENERS = %w[
      sugar brown\ sugar corn\ syrup
      agave molasses honey maple\ syrup stevia
    ].freeze

    FATS = %w[butter cream sour\ cream canola\ oil olive\ oil margerine shortening egg].freeze

    WATER = %w[water milk].freeze

    FLOURS = %w[
      flour bread\ flour high\ gluten\ flour ap\ flour all\ purpose\ flour
      spelt wheat\ flour whole\ wheat\ flour cake\ flour pastry\ flour semolina
      durum corn\ meal flax\ meal cornmeal
    ].freeze
  end
end