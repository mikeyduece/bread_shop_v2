# frozen_string_literal: true

RSpec.shared_examples 'shared recipes examples' do
  expect(service.success?).to be(true)
  expect(recipe).to be_an_instance_of(Recipe)
  expect(user.recipes).to include(service.recipe)
end
