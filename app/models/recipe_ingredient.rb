class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  before_save :ensure_bakers_percentage

  private

  def ensure_bakers_percentage 
    self.bakers_percentage = calculate_bakers_percentage
  end

  def calculate_bakers_percentage
    # TODO: Fix infinity error with flour
    flour_amt = recipe.flour_amts
    ((amount / flour_amt) * 100).round(2)
  end
end