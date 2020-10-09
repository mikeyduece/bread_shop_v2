require 'rails_helper'

RSpec.describe Recipes::Create, type: :service do
  include_context 'shared recipe params'
  let(:user) { create(:user) }
  subject { described_class.call(user: user, params: lean_create_params) }
  
  it 'creates a recipe for the logged in user' do
    recipe = subject.recipe
    expect(subject.success?).to be(true)
    expect(recipe).to be_an_instance_of(Recipe)
    expect(user.recipes).to include(subject.recipe)
    require 'pry'; binding.pry
    expect(recipe.family_name).to eq('lean')
  end
  
end