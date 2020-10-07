module AuthenticationHelpers

  def login_as_user(user)
    user = user || create(:user)
    allow_any_instance_of(ApiController).to receive(:authenticate_request!).and_return(true)
    allow_any_instance_of(ApiController).to receive(:current_user).and_return(user)
  end
end