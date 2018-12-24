class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :family, optional: true

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
end
