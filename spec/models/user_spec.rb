require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }
  
  context :associations do
    it { should have_many(:recipes) }
    it { should have_many(:forum_topics) }
    it { should have_many(:comments) }
    it { should have_many(:access_grants) }
    it { should have_many(:access_tokens) }
  end
end
