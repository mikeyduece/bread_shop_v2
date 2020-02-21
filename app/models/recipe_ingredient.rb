class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  
  before_commit :ensure_bakers_percentage, on: %i[create update]
  
  scope :amount_totals_by_category, -> {
    joins(ingredient: :category)
      .group('categories.name')
      .sum(:amount)
      .with_indifferent_access
  }
  
  private
  
  def ensure_bakers_percentage
    self.bakers_percentage = calculate_bakers_percentage
  end
  
  def calculate_bakers_percentage
    flour_amt = recipe.flour_amts
    ((amount / flour_amt) * 100).round(2)
  end
end