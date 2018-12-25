class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :family, optional: true

  has_many :recipe_ingredients, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }

  def ingredients
    list = {}
    recipe_ingredients.includes(:ingredient).find_each do |recipe_ingredient|
      # ingredient = ingredients.find(recipe_ingredient.ingredient_id)
      list[recipe_ingredient.ingredient.name] = {
        amount: recipe_ingredient.amount,
        bakers_percentage: "#{recipe_ingredient.bakers_percentage}%"
      }
    end
    list
  end

  def lean
    return true if sweet_and_fat_amts.all? { |amt| low.include?(amt) }
  end

  def soft
    if (water_percentage + fat_percentage) < 70.0 &&
        MODERATE.include?(sweetener_percentage) &&
        MODERATE.include?(fat_percentage)
      true
    end
  end

  def rich
    if (MODERATE.include?(sweetener_percentage) &&
        high.include?(fat_percentage)) ||
        high.include?(fat_percentage)
      true
    end
  end

  def slack
    return true if water_percentage + fat_percentage > 70.0
  end

  def sweet
    return true if sweet_and_fat_amts.all? { |amt| HIGH.include?(amt) }
  end

  def family_assignment(name)
    Family.find_by(name: name).id
  end

  def sum_recipe_ingredient_amounts(category)
    category = Category.find_by(name: category)
    recipe_ingredients.includes(:ingredient)
      .where(ingredients: { category: category })
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
    sum_recipe_ingredient_amounts('flour')
  end

  def sweetener_amounts
    sum_recipe_ingredient_amounts('sweetener')
  end

  def fat_amounts
    sum_recipe_ingredient_amounts('fat')
  end

  def water_amt
    sum_recipe_ingredient_amounts('water')
  end

end
