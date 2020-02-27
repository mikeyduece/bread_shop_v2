require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject { Admin.create(email: 'admin@admin.com') }

  context :associations do
    it { should have_many(:forums) }
    it { should have_many(:forum_topics) }
    it { should have_many(:access_grants) }
    it { should have_many(:access_tokens) }
  end
end
