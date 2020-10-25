require 'rails_helper'

RSpec.describe 'User API' do
  include_context 'shared headers'
  let! (:params) do
    {
      data: {
        type:       :user,
        attributes: {
          "first_name":   "Mike",
          "last_name":    "Heft",
          "phone_number": "+3530867806063",
          "email":        "mikeheft@gmail.com",
          "password":     "password"
        }
      }
    }
  end
  
  let(:user) { create(:user) }
  
  context 'Authorized' do
    before { login_as_user(user) }
    
    it 'creates user' do
      post '/api/v1/users/users', params: params, headers: headers
      
      expect(response).to be_successful
      user_data = json_response
      
      expect(user_data.dig(:data, :attributes, :first_name)).to eq('Mike')
      expect(User.last.first_name).to eq('Mike')
    end
    
    it 'shows a Users profile information' do
      get "/api/v1/users/users/#{user.id}", headers: headers
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      user_json = json_response
      
      expect(user_json.dig(:data, :id)).to eq(user.id.to_s)
      expect(user_json.dig(:data, :attributes, :first_name)).to eq(user.first_name)
      expect(user_json.dig(:data, :attributes, :last_name)).to eq(user.last_name)
    end
  end
  
  context 'Unauthorized' do
    include_context 'shared headers'
    it 'doesn\'t allow User to see profile info if not logged in' do
      get "/api/v1/users/users/#{user.id}", headers: headers
      
      expect(response).to_not be_successful
      expect(response.status).to eq(401)
    end

    it 'should raise routing error if no accept header present' do
      login_as_user(user)
      expect{ get "/api/v1/users/users/#{user.id}" }.to raise_error(ActionController::RoutingError)
    end
  end

end
