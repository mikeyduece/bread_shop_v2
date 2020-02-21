class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  
  scope :amounts_by_category, ->(category_name) {
    category = Category.find_by(name: category_name)
    require 'pry'; binding.pry
    includes(:ingredient).where(ingredients: { category: category })
                         .sum(:amount)
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