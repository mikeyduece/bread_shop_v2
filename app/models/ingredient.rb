# frozen_string_literal: true

class Ingredient < ApplicationRecord
  belongs_to :category

  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true, uniqueness: true

  before_validation :ensure_category, on: :create

  delegate :name, to: :category, prefix: true

  private def ensure_category
    return unless name

    name = self.name&.downcase
    self.category = case
                    when check_for_category_inclusion(Api::Ingredients::SWEETENERS, name)
                      set_category(:sweetener)
                    when check_for_category_inclusion(Api::Ingredients::FATS, name)
                      set_category(:fat)
                    when check_for_category_inclusion(Api::Ingredients::LIQUID_FATS, name)
                      set_category(:liquid_fat)
                    when check_for_category_inclusion(Api::Ingredients::FLOURS, name)
                      set_category(:flour)
                    when check_for_category_inclusion(Api::Ingredients::WATER, name)
                      set_category(:water)
                    else
                      Category.find_or_create_by(name: :other)
                    end
  end

  private def check_for_category_inclusion(constant, ingredient_name)
    constant.any? { |i| ingredient_name.match?(/(#{i})/) }
  end

  private def set_category(category_name)
    Category.find_or_create_by(name: category_name.to_s.titleize.downcase)
  end
end
