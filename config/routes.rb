Rails.application.routes.draw do
  root "products#index"

  resource :account, { except: [ :destroy ], controller: :users, as: :user, format: false }

  get 'login' => 'sessions#new', format: false
  post 'login' => 'sessions#create', format: false
  delete 'logout' => 'sessions#destroy', format: false

  # resource :login, {controller: :sessions, as: :session, only: [ :new, :create ], format: false }

  resources :products, only: [ :index, :show ], format: false
  resources :cart_products, only: [ :index, :create, :update, :destroy ], format: false
  resources :orders, only: [ :index, :new, :create, :show ], format: false

  namespace :admin do
    root "orders#index"

    get 'login' => 'sessions#new', format: false
    post 'login' => 'sessions#create', format: false
    delete 'logout' => 'sessions#destroy', format: false

    resources :users, only: [ :index, :show, :edit, :update, :destroy ], format: false
    resources :products, format: false
    resources :orders, only: [ :index, :show ], format: false
  end
end
