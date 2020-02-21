require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { create(:user) }
  
  context :associations do
    it { belong_to(:family) }
    it { belong_to(:user) }
    it { have_many(:recipe_ingredients) }
    it { have_many(:ingredients).through(:recipe_ingredients) }
  end
  
  context :instance_methods do
    # TODO: This might be better suited as a scope in rec ing
    it '#flour_amts' do
      recipe = build(:recipe)
      
      flour1 = create(:ingredient, name: 'ap flour')
      flour2 = create(:ingredient, name: 'bread flour')
      sugar = create(:ingredient, name: 'sugar')
      
      rec_ing1 = build(:recipe_ingredient, ingredient: flour1, amount: 100.00)
      rec_ing2 = build(:recipe_ingredient, ingredient: flour2, amount: 300.00)
      rec_ing3 = build(:recipe_ingredient, ingredient: sugar)
      
      recipe.recipe_ingredients = [rec_ing1, rec_ing2, rec_ing3]
      recipe.save
      
      flour = recipe.flour_amts
      expect(flour).to eq(400.00)
    end
    
    it 'raises NoFlourError with no flour in recipe' do
      create(:category, name: :flour)
      recipe = create(:recipe)
      
      expect { recipe.flour_amts }.to raise_error(Recipes::NoFlourError)
    end
  end
  
end
