Rails.application.routes.draw do

  root "products#index"

  resource :account, { controller: :users }

  get 'login' => 'sessions#new', as: :login
  resource :session, only: [ :create, :destroy ]

  resources :products, only: [ :index, :show ]
  resources :cart_products, only: [ :index, :create, :update, :destroy ]
  resources :orders

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
