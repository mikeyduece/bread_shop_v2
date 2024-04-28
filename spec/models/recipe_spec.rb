# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { create(:user) }

  context :associations do
    it { belong_to(:family) }
    it { belong_to(:user) }
    it { have_many(:recipe_ingredients) }
    it { have_many(:ingredients).through(:recipe_ingredients) }
  end

  context :callbacks do
    it 'should callback to #calcualte_family' do
      recipe = build(:recipe)

      expect(recipe).to receive(:calculate_family)
      recipe.save
    end
  end

  context :errors do
    it 'should raise NoFlourError if no flour present in recipe' do
      recipe = build(:recipe)
      recipe.recipe_ingredients.clear

      expect { recipe.save }.to raise_error(Recipes::NoFlourError)
    end
  end
end
