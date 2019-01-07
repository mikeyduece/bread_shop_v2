Rails.application.routes.draw do
  use_doorkeeper
  root to: 'home#index'
  
  devise_for :users
  devise_for :admins
  
  namespace :api do
    namespace :v1 do
      resources :recipes, module: :recipes, controller: :recipes, only: :show do
        resources :comments, except: %i[new edit]
      end

      resources :users, module: :users, controller: :users, except: %i[new edit] do
        put :activate
        delete :forget

        resources :recipes, except: %i[new edit]
      end
    end
  end
end
