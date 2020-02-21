require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { create(:user) }
  
  context :associations do
    it { belong_to(:family) }
    it { belong_to(:user) }
    it { have_many(:recipe_ingredients) }
    it { have_many(:ingredients).through(:recipe_ingredients) }
  end
  
end
