Rails.application.routes.draw do

  root "products#index"

  resource :account, { controller: :users }

  get 'login' => 'sessions#new', as: :login
  resource :session, only: [ :create, :destroy ]

  resources :products, only: [ :index, :show ]
  resources :cart_products, only: [ :index, :create, :update, :destroy ]
  resources :orders

  namespace :admin do
    root "sessions#new"
    get 'login' => 'sessions#new', as: :login
    resource :session, only: [ :create, :destroy ]

    resources :users, only: [ :index, :show, :edit, :update, :destroy ]
    resources :products
    resources :orders, only: [ :index, :show, :edit, :update ]

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
