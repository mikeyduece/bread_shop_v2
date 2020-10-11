class Users::BaseUsersService < BaseService
  
  def initialize(params:, user: nil)
    @user = user
    @params = params
  end
  
  private
  
  attr_reader :params, :user

end
