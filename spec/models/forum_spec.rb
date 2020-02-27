require 'rails_helper'

describe Forum, type: :model do
    it { should belong_to(:admin) }
    it { should validate_presence_of(:title) }
    it { should have_many(:forum_topics) }
  
end