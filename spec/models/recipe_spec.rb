require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject { create(:recipe) }
  context :associations do
    it { should belong_to(:family) }
    it { should belong_to(:user) }
    it { should have_many(:recipe_ingredients) }
    it { should have_many(:ingredients).through(:recipe_ingredients) }
  end

  context :instance_methods do
  end

end
