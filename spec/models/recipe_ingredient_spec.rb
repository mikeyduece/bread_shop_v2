require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  subject { create(:user) }
  context :associations do
    it { belong_to(:recipe) }
    it { belong_to(:ingredient) }
  end
  
end
