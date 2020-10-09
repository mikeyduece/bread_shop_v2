Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :recipes, module: :recipes, only: :show do
        put :scale
        
        resources :comments, except: %i[new edit]
      end
      
      namespace :users do
        resource :me, only: %i[create show update]
        
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