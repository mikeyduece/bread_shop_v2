require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(first_name: 'Mike', last_name: 'Heft', email: 'myemail@gmail.com', phone_number: '1234567890') }
  context :associations do
    it { should have_many(:recipes) }
    it { should have_many(:forums) }
    it { should have_many(:comments) }
  end
end
