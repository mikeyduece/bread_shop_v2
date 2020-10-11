module Users
  class CreateService < BaseUsersService
    
    def call
      user = create_user
      
      Success.new(user: user)
    rescue StandardError => e
      handle_error(e)
    end
    
    private
    
    def create_user
      attrs = attributes(params)
      User.create!(attrs)
    end
  
  end
end
