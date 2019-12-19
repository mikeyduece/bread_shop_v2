class Recipe < ApplicationRecord
  include Api::RecipeHelper
  include Likeable

  liker :user
  
  belongs_to :user
  belongs_to :family

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  has_many :comments, as: :commentable, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :number_of_portions, presence: true, numericality: { greater_than: 0 }
  validates :weight_per_portion, presence: true, numericality: { greater_than: 0 }

  def formatted_ingredients
    list = []
    recipe_ingredients.includes(:ingredient).find_each do |recipe_ingredient|
      list << {
        name: recipe_ingredient.ingredient.name,
        amount: recipe_ingredient.amount,
        bakers_percentage: "#{recipe_ingredient.bakers_percentage}%"
      }
    end

    list
  end

  def total_percentage
    recipe_ingredients.sum('recipe_ingredients.bakers_percentage')
  end

  def new_flour_weight(params: params)
    ((new_total_weight(params: params) / total_percentage) * 100).round(2)
  end

  def new_total_weight(params:)
    params[:number_of_portions] * params[:weight_per_portion]
  end

  def new_totals(params:)
    scaled = []
    recipe_ingredients.includes(:ingredient).find_each do |recipe_ingredient|
      new_amount = (new_flour_weight(params: params) * (recipe_ingredient.bakers_percentage.to_f / 100)).round(2)
      new_amount = new_flour_weight(params: params) if recipe_ingredient.ingredient.name.eql?(:flour)

      scaled << {
        name: recipe_ingredient.ingredient.name,
        amount: new_amount,
        bakers_percentage: "#{recipe_ingredient.bakers_percentage}%"
      }
    end

    scaled
  end
end
