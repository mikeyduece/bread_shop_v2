require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  subject { create(:user) }
  
  context :associations do
    it { belong_to(:recipe) }
    it { belong_to(:ingredient) }
  end
  
  context :instance_methods do
    it 'should callback to #ensure_bakers_percentage' do
      recipe_ingredient = create(:recipe_ingredient)
      expect(recipe_ingredient).to receive(:ensure_bakers_percentage)
      recipe_ingredient.save
    end
  end
  
end
