Rails.application.routes.draw do
  use_doorkeeper
  root to: 'home#index'
  
  devise_for :users
  devise_for :admins
  
  namespace :api do
    namespace :v1 do
      resources :users, module: :users, controller: :users do
        put :activate
        delete :forget
      end
    end
  end
end
