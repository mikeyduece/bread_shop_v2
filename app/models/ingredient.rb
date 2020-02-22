class Ingredient < ApplicationRecord
  
  belongs_to :category
  
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
  
  validates :name, presence: true, uniqueness: true
  
  before_validation :ensure_category, on: :create
  
  private
  
  def ensure_category
    return unless self.name
    
    name = self.name&.downcase
    case
      when check_for_category_inclusion(Api::Ingredients::SWEETENERS, name)
        self.category = set_category(:sweetener)
      when check_for_category_inclusion(Api::Ingredients::FATS, name)
        self.category = set_category(:fat)
      when check_for_category_inclusion(Api::Ingredients::FLOURS, name)
        self.category = set_category(:flour)
      when check_for_category_inclusion(Api::Ingredients::WATER, name)
        self.category = set_category(:water)
      else
        self.category = Category.find_or_create_by(name: :other)
    end
  end
  
  def check_for_category_inclusion(constant, ingredient_name)
    ingredient_name = ingredient_name.split.join('|')
    
    constant.any? { |i| /(#{ingredient_name})/ =~ i}
  end
  
  def set_category(category_name)
    Category.find_or_create_by(name: category_name)
  end
end
