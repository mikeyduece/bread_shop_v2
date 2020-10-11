require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  subject { create(:user) }
  
  context :associations do
    it { belong_to(:recipe) }
    it { belong_to(:ingredient) }
  end
  
  context :instance_methods do
    it 'should callback to #ensure_bakers_percentage' do
      recipe_ingredient = build(:recipe_ingredient)
      expect(recipe_ingredient).to receive(:ensure_bakers_percentage)
      recipe_ingredient.save
    end
  end
  
  context :scopes do
    it '.amount_totals_by_category' do
      recipe_ingredient = create(:recipe_ingredient)
      recipe = recipe_ingredient.recipe
      
      actual = recipe.recipe_ingredients.amount_totals_by_category
      
      expect(actual).to be_a(Hash)
      expect(actual).to_not be_nil
      expect(actual.keys).to include('flour')
    end
  end
  
end
