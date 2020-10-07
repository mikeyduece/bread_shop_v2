Rails.application.routes.draw do
  use_doorkeeper
  root to: 'home#index'
  
  devise_for :users
  devise_for :admins
  
  namespace :api do
    namespace :v1 do
      resources :recipes, module: :recipes, only: :show do
        put :scale
        
        resources :comments, except: %i[new edit]
      end
      
      resources :users, module: :users, only: %i[create show update] do
        
        resources :recipes, module: :recipes, except: %i[new edit]
      end
      
      resources :forums, module: :forums, except: %i[new edit] do
        put :activate
        delete :forget
        
        resources :comments, except: %i[new edit]
      end
    end
  end
end