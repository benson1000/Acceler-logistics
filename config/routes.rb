Rails.application.routes.draw do
  devise_for :users
  devise_for :companies, controllers: { registrations: 'companies/registrations' }
  devise_scope :company do
    get 'companies/sign_up', to: 'companies/registrations#new'
    post 'companies', to: 'companies/registrations#create'
  end
  # Route for company dashboard or profile
  get '/company', to: 'companies#dashboard', as: 'company'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :companies do
    resources :orders, only: [:new, :create]
  end

  get '/about', to: 'pages#about'
  resources :contacts
  root "pages#home"

  resources :orders, only: [:new, :create, :show]
  get '/order_history', to: 'orders#order_history'
  get '/orders/:id/cancel', to: 'orders#cancel', as: 'cancel_order'
  get '/orders/:id/payment', to: 'orders#payment', as: 'order_payment'
  post '/orders/:id/process_payment', to: 'orders#process_payment', as: 'process_payment'
  get '/cancelled_orders', to: 'orders#cancelled_orders', as: 'cancelled_orders'
  resources :profiles, only: [:show]


  # Defines the root path route ("/")
  # root "articles#index"

end
