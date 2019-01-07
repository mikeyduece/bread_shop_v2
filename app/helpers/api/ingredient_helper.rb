module Api
  module IngredientHelper
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