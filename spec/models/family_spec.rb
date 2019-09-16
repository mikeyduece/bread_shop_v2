require 'rails_helper'

RSpec.describe Family, type: :model do
  subject { Family.new(name: 'Category 1') }

  context :associations do
    it { should have_many(:recipes) }
  end

  context :validations do
    it { should validate_uniqueness_of(:name) }
  end
end