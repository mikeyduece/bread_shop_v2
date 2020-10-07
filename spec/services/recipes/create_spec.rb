require 'rails_helper'

RSpec.describe Recipes::Create, type: :service do
  subject { described_class.call(user, params) }
  let(:user) { create(:user) }
  
end