Rails.application.routes.draw do
  root "products#index"

  resource :account, { controller: :users, as: :user, format: false }

  get 'login' => 'sessions#new', format: false
  post 'login' => 'sessions#create', format: false
  delete 'logout' => 'sessions#destroy', format: false

  # resource :login, {controller: :sessions, as: :session, only: [ :new, :create ], format: false }

  resources :products, only: [ :index, :show ], format: false
  resources :cart_products, only: [ :index, :create, :update, :destroy ], format: false
  resources :orders, format: false

  namespace :admin do
    root "sessions#new"

    get 'login' => 'sessions#new', as: :login, format: false
    resource :session, only: [ :create, :destroy ], format: false

    resources :users, only: [ :index, :show, :edit, :update, :destroy ], format: false
    resources :products, format: false
    resources :orders, only: [ :index, :show, :edit, :update ], format: false
  end
end
