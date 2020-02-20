class Ingredient < ApplicationRecord

  belongs_to :category
  
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true, uniqueness: true

  before_commit :ensure_category, on: :create

  private

  def ensure_category
    name = self[:name].downcase

    case
    when category_include?(constant: Api::Ingredients::SWEETENERS, kind: name) then update_attributes(category: category_assignment(:sweetener))
    when category_include?(constant: Api::Ingredients::FATS, kind: name)       then update_attributes(category: category_assignment(:fat))
    when category_include?(constant: Api::Ingredients::FLOURS, kind: name)     then update_attributes(category: category_assignment(:flour))
    when category_include?(constant: Api::Ingredients::WATER, kind: name)      then update_attributes(category: category_assignment(:water))
    end
  end

  def category_include?(constant:, kind:)
    constant.any? { |c| kind.include?(c) }
  end

  def category_assignment(category_name)
    Category.find_or_create_by(name: category_name)
  end
end
