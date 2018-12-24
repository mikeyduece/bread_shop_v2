class Ingredient < ApplicationRecord
  include Api::IngredientHelper

  has_one :category

  before_save :ensure_category

  private

  def ensure_category
    puts '##################################'
    puts 'INGREDIENT'
    puts self.name
  end
end
