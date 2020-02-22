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
  
  it 'creates user' do
    post '/api/v1/users', params: params
    
    expect(response).to be_successful
    
    user_data = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    
    expect(user_data[:name]).to eq('Mike Heft')
    expect(User.last.first_name).to eq(params[:user][:first_name])
  end
end
