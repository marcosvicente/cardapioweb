require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  resources :restaurants
  resources :owners
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'authentications/login'
  resources :users

  get "administrations/:id/restaurants_owner", to: "administrations#restaurants_owner"
  put "administrations/change_restaurant_to_owner", to: "administrations#change_restaurant_to_owner"
  get "administrations/get_opened_restaurant", to: "administrations#get_opened_restaurant"
end
