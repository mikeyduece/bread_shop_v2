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
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user.id) }
  
  it 'creates user' do
    post '/api/v1/users', params: params
    
    expect(response).to be_successful
    
    user_data = JSON.parse(response.body, symbolize_names: true)
    
    expect(user_data[:user][:first_name]).to eq('Mike')
    expect(User.last.first_name).to eq(params[:user][:first_name])
  end
  
  it 'shows a Users profile information' do
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token)
    
    get '/api/v1/users/me'
    
    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    user_json = JSON.parse(response.body, symbolize_names: true)
    expect(user_json[:user][:id]).to eq(user.id)
    expect(user_json[:user][:first_name]).to eq(user.first_name)
    expect(user_json[:user][:last_name]).to eq(user.last_name)
  end
  
  it 'doesn\'t allow User to see profile info if not logged in' do
    get api_v1_user_path(User.last)
    
    expect(response).to_not be_successful
    expect(response.status).to eq(401)
  end
end
