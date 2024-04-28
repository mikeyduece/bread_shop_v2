# frozen_string_literal: true

module Users
  class BaseUsersService < BaseService
    def initialize(params:, user: nil)
      @user = user
      @params = params
    end

    attr_reader :params, :user
  end
end
