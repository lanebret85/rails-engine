Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      namespace :items do
        resources :find, only: [:index], controller: '/api/v1/items/search'
      end

      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: [:index], controller: '/api/v1/items/merchant'
      end
    end
  end
end
