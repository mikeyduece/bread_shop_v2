Rails.application.routes.draw do
  use_doorkeeper
  root to: 'home#index'

  devise_for :users
  devise_for :admins
end
