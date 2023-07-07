Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/about', to: 'pages#about'
  resources :contacts
  root "pages#home"

  resources :orders, only: [:new, :create, :show]
  resources :profiles, only: [:show]

  # Defines the root path route ("/")
  # root "articles#index"
end
