class Recipe < ApplicationRecord
  include Api::RecipeHelper
  
  belongs_to :user
  belongs_to :family, optional: true

  has_many :recipe_ingredients, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }

  def ingredients
    list = {}
    recipe_ingredients.includes(:ingredient).find_each do |recipe_ingredient|
      list[recipe_ingredient.ingredient.name] = {
        amount: recipe_ingredient.amount,
        bakers_percentage: "#{recipe_ingredient.bakers_percentage}%"
      }
    end
    list
  end

  def total_percentage 
    recipe_ingredients.sum('recipe_ingredients.bakers_percentage')
  end

  def lean?
    sweet_and_fat_amts.all? { |amt| LOW.include?(amt) }
  end

  def soft?
    (water_percentage + fat_percentage) < 70.0 &&
        MODERATE.include?(sweetener_percentage) &&
        MODERATE.include?(fat_percentage)
  end

  def rich?
    (MODERATE.include?(sweetener_percentage) &&
        HIGH.include?(fat_percentage)) ||
        HIGH.include?(fat_percentage)
  end

  def slack?
    water_percentage + fat_percentage > 70.0
  end

  def sweet?
    # HIGH.include?(sweetener_percentage) && MODERATE.include?(fat_percentage)
    sweet_and_fat_amts.all? { |amt| HIGH.include?(amt) }
  end

  def calculate_family
    case
    when lean? then update_attributes(family_id: family_assignment(:lean))
    when soft? then update_attributes(family_id: family_assignment(:soft))
    when sweet? then update_attributes(family_id: family_assignment(:sweet))
    when rich? then update_attributes(family_id: family_assignment(:rich))
    when slack? then update_attributes(family_id: family_assignment(:slack))
    end
  end

  def family_assignment(name)
    Family.find_by(name: name).id
  end

  def sum_recipe_ingredient_amounts(category_name)
    category = Category.find_by(name: category_name)
    recipe_ingredients.includes(:ingredient)
      .where(ingredients: { category_id: category.id })
      .sum(:amount)
  end

  def destroy_all_recipe_ingredients
    recipe_ingredients.delete_all
  end

  def sweetener_percentage
    sweets = sweetener_amounts
    calculate_percentage(sweets)
  end

  def fat_percentage
    fats = fat_amounts
    calculate_percentage(fats)
  end

  def water_percentage
    water = water_amt
    calculate_percentage(water)
  end

  def sweet_and_fat_amts
    [sweetener_percentage, fat_percentage]
  end

  def calculate_percentage(category_amount)
    ((category_amount / flour_amts) * 100).round(2)
  end

  def flour_amts
    sum_recipe_ingredient_amounts(:flour)
  end

  def sweetener_amounts
    sum_recipe_ingredient_amounts(:sweetener)
  end

  def fat_amounts
    sum_recipe_ingredient_amounts(:fat)
  end

  def water_amt
    sum_recipe_ingredient_amounts(:water)
  end

end
