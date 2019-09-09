require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  subject { Ingredient.new(name: 'Flour') }

  context :associations do
    it { should belong_to(:category) }
    it { should have_many(:recipe_ingredients) }
    it { should have_many(:recipes).through(:recipe_ingredients) }
  end

  context :validations do
    it {  should validate_uniqueness_of(:name)}
  end
end
