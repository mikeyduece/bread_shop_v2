require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { Category.new(name: 'Category 1') }

  context :associations do
    it { have_many(:ingredients) }
  end

  context :validations do
    it { should validate_uniqueness_of(:name) }
  end
end