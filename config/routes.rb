Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      namespace :items do
        resources :find, only: [:index], controller: '/api/v1/items/search'
      end

      namespace :merchants do
        resources :find_all, only: [:index], controller: '/api/v1/merchants/search'
      end

      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: [:index], controller: '/api/v1/items/merchant'
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: '/api/v1/merchants/items'
      end
    end
  end
end
