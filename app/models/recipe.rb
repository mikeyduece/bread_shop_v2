class Recipe < ApplicationRecord
  include Recipes::FamilyCalculator
  # include Likeable
  # include Commentable
  
  # liker :user
  # commenter :user
  
  belongs_to :user
  belongs_to :family, optional: true
  
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :categories, through: :ingredients
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags
  
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
  validates :number_of_portions, :weight_per_portion, presence: true, numericality: { greater_than: 0 }
  
  after_commit :calculate_family, on: %i[create update]
  
  enum unit: %i[oz lbs g kg]
  
  accepts_nested_attributes_for :recipe_ingredients, reject_if: :all_blank, allow_destroy: true
  
  delegate :name, to: :family, prefix: true, allow_nil: true
  
  def flour_amounts
    flour = sum_recipe_ingredient_amounts[:flour]
    return flour if flour && !flour.zero?
    
    raise Recipes::NoFlourError
  end
  
  def formatted_ingredients
    totals = recipe_ingredients.includes(:ingredient).each_with_object([]) do |recipe_ingredient, acc|
      formatted_ingredient_values(recipe_ingredient, acc)
    end
    
    { ingredients: totals }
  end
  
  def total_percentage
    recipe_ingredients.sum(:bakers_percentage).round(2)
  end
  
  def total_dough_weight
    recipe_ingredients.sum(:amount).round(2)
  end
  
  def new_flour_weight(new_weight)
    ((new_weight / total_percentage.to_f) * 100).round(2)
  end
  
  def new_totals(flour_weight)
    totals = recipe_ingredients.includes(:ingredient).each_with_object([]) do |recipe_ingredient, acc|
      new_amount = (flour_weight * (recipe_ingredient.bakers_percentage.to_f / 100)).round(2)
      new_amount = flour_weight if recipe_ingredient.ingredient_name.match?('flour')
      
      formatted_ingredient_values(recipe_ingredient, acc, new_amount)
    end
    
    { ingredients: totals }
  end
  
  private
  
  def formatted_ingredient_values(recipe_ingredient, accumulator, new_amount = nil)
    accumulator << {
      name: recipe_ingredient.ingredient_name,
      amount: new_amount || recipe_ingredient.amount,
      bakers_percentage: recipe_ingredient.bakers_percentage
    }
  end

end
