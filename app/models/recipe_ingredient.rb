class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  has_one :category, through: :ingredient

  before_commit :ensure_bakers_percentage, on: %i[create update]
  
  scope :amount_totals_by_category, -> {
    joins(ingredient: :category)
      .group('categories.name')
      .sum(:amount)
      .with_indifferent_access
  }
  
  delegate :name, :category_name, to: :ingredient, prefix: true
  delegate :name, :category_name, to: :category, prefix: true
  
  private
  
  def ensure_bakers_percentage
    update_columns(bakers_percentage: calculate_bakers_percentage)
  end
  
  def calculate_bakers_percentage
    flour_amt = recipe.flour_amounts
    ((amount / flour_amt) * 100).round(2)
    
  rescue Recipes::NoFlourError => e
    recipe.errors[:base] << e.message
    0.0
  end
end