Rails.application.routes.draw do
  use_doorkeeper
  root to: 'home#index'
  
  devise_for :users
  devise_for :admins
  
  namespace :api do
    namespace :v1 do
      resources :recipes, module: :recipes, only: :show do
        resources :comments, except: %i[new edit]
      end

      resources :users, module: :users, except: %i[new edit] do
        put :activate
        delete :forget

        resources :recipes, except: %i[new edit]
      end

      resources :comments, module: :comments, except: %i[new edit] do
        put :activate
        delete :forget
      end

      resources :forums, module: :forums, except: %i[new edit] do
        put :activate
        delete :forget

        resources :comments, except: %i[new edit]
      end
    end
  end
end
