Rails.application.routes.draw do
  resources :restaurants
  resources :owners
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'authentications/login'
  resources :users

end
