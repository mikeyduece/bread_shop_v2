require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(first_name: 'Mike', last_name: 'Heft', email: 'myemail@gmail.com', phone_number: '1234567890') }
  context :associations do
    it { have_many(:recipes) }
    it { have_many(:forums) }
    it { have_many(:comments) }
    it { have_many(:recipe_likes) }
    it { have_many(:comment_likes) }
    it { have_many(:forum_likes) }
  end
end
