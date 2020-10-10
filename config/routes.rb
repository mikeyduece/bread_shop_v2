Rails.application.routes.draw do
  api_version(module: 'Api::V1', defaults: { format: :json }, header: { name: 'Accept', value: 'application/vnd.breadshop.json; version=1' }) do
    scope path: :api do
      scope path: :v1 do
        resources :recipes, module: :recipes, only: :show do
          put :scale
          
          resources :comments, except: %i[new edit]
        end
        
        namespace :users do
          resources :users, only: %i[create show update]
          
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
end
