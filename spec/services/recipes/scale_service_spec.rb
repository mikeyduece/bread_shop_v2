require 'rails_helper'

RSpec.describe Recipes::ScaleService, type: :service do
  let(:recipe) { create(:recipe) }
  let(:params) do
    {
      data: {
        type: :recipe,
        id: recipe.id,
        attributes: { number_of_portions: recipe.number_of_portions * 2, weight_per_portion: 10 }
      }
    }
  end
  
  subject { described_class.call(params: params) }
  
  it 'should scale the recipe accordingly' do
    new_totals = subject.scaled_recipe
    flour = new_totals.select {|h| h.match?('flour')}
    others = new_totals.reject {|h| h.match('flour')}
    flour_total = flour.values.sum { |h| h[:amount] }
    correct_percentages = others.values.all? {|h| (flour_total * h[:bakers_percentage] / 100).round(2) == h[:amount] }
    correct_dough_weight = recipe.number_of_portions * recipe.weight_per_portion
    
    expect(correct_percentages).to be(true)
    expect(subject.scaled_dough_weight).to eq(correct_dough_weight)
  end

end
