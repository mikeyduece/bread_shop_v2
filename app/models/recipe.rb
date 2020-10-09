class Recipe < ApplicationRecord
  include Recipes::FamilyCalculator
  include Likeable
  include Commentable
  
  liker :user
  commenter :user
  
  belongs_to :user
  belongs_to :family, optional: true
  
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :categories, through: :ingredients
  
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
  validates :number_of_portions, :weight_per_portion, presence: true, numericality: { greater_than: 0 }
  
  before_commit :calculate_family#, on: :create
  
  enum unit: %i[oz lbs g kg]
  
  delegate :name, to: :family, prefix: true, allow_nil: true
  
  def flour_amounts
    flour = sum_recipe_ingredient_amounts[:flour]
    return flour if flour && !flour.zero?
    
    raise Recipes::NoFlourError
  end
  
  def formatted_ingredients
    list = []
    recipe_ingredients.includes(:ingredient).find_each do |recipe_ingredient|
      list << {
        name: recipe_ingredient.ingredient_name,
        amount: recipe_ingredient.amount,
        bakers_percentage: "#{recipe_ingredient.bakers_percentage}%"
      }
    end
    
    list
  end
  
  def total_percentage
    recipe_ingredients.sum(:bakers_percentage)
  end
  
  def new_flour_weight(params:)
    ((new_total_weight(params: params) / total_percentage) * 100).round(2)
  end
  
  def new_total_weight(params:)
    params[:number_of_portions] * params[:weight_per_portion]
  end
  
  def new_totals(params:)
    scaled = []
    recipe_ingredients.includes(:ingredient).find_each do |recipe_ingredient|
      new_amount = (new_flour_weight(params: params) * (recipe_ingredient.bakers_percentage.to_f / 100)).round(2)
      new_amount = new_flour_weight(params: params) if recipe_ingredient.ingredient_name.eql?(:flour)
      
      scaled << {
        name: recipe_ingredient.ingredient_name,
        amount: new_amount,
        bakers_percentage: "#{recipe_ingredient.bakers_percentage}%"
      }
    end
    
    scaled
  end
end
