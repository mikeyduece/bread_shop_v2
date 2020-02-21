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
      when Api::Ingredients::SWEETENERS.any?(name)
        self.category = set_category(:sweetener)
      when Api::Ingredients::FATS.any?(name)
        self.category = set_category(:fat)
      when Api::Ingredients::FLOURS.any?(name)
        self.category = set_category(:flour)
      when Api::Ingredients::WATER.any?(name)
        self.category = set_category(:water)
    end
  end
  
  def set_category(category_name)
    Category.find_or_create_by(name: category_name)
  end
end
