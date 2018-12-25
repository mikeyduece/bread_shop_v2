class Ingredient < ApplicationRecord
  include Api::IngredientHelper

  belongs_to :category, optional: true
  
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  after_create :ensure_category

  private

  def ensure_category
    name = self[:name].downcase

    case
    when SWEETENERS.include?(name) then update_attribute(:category, category_assignment('sweetener'))
    when FATS.include?(name)       then update_attribute(:category, category_assignment('fat'))
    when FLOURS.include?(name)     then update_attribute(:category, category_assignment('flour'))
    when WATER.include?(name)      then update_attribute(:category, category_assignment('water'))
    end
  end

  def category_assignment(category_name)
    Category.find_or_create_by(name: category_name)
  end
end
