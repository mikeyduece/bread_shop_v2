require 'rails_helper'

RSpec.describe 'User API' do
  let! (:params) { {
    "user": {
      "first_name":   "Mike",
      "last_name":    "Heft",
      "phone_number": "+3530867806063",
      "email":        "mikeheft@gmail.com",
      "password":     "password"
    }
  } }
  
  let!(:user) { create(:user) }
  
  it 'creates user' do
    post '/api/v1/users', params: params
    
    expect(response).to be_successful
    
    user_data = JSON.parse(response.body, symbolize_names: true)
    
    expect(user_data[:user][:first_name]).to eq('Mike')
    expect(User.last.first_name).to eq(params[:user][:first_name])
  end

  it 'doesn\'t allow User to see profile info if not logged in' do
    get api_v1_user_path(User.last)
    require 'pry'; binding.pry
  end
end
