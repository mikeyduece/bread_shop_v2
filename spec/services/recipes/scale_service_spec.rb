# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipes::ScaleService, type: :service do
  def match_flour(element, method)
    element.send(method) { |h| h[:name].match?('flour') }
  end

  let(:recipe) { create(:recipe) }
  let(:new_number_of_portions) { recipe.number_of_portions * 2 }
  let(:new_weight_per_portion) { recipe.weight_per_portion }
  let(:params) do
    {
      data: {
        type: :recipe,
        id: recipe.id,
        attributes: { number_of_portions: new_number_of_portions, weight_per_portion: new_weight_per_portion }
      }
    }
  end

  subject { described_class.call(params: params) }

  it 'should scale the recipe accordingly' do
    new_totals = subject.scaled_recipe
    flour = match_flour(new_totals[:ingredients], :select)
    others = match_flour(new_totals[:ingredients], :reject)
    flour_total = flour.sum { |h| h[:amount] }
    correct_percentages = others.all? { |h| (flour_total * h[:bakers_percentage] / 100).round(2) == h[:amount] }
    correct_dough_weight = new_number_of_portions * new_weight_per_portion

    expect(correct_percentages).to be(true)
    expect(subject.scaled_dough_weight).to eq(correct_dough_weight)
  end
end
