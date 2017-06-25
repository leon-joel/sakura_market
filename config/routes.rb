Rails.application.routes.draw do

  root "products#index"

  resources :order_products
  resources :orders
  resources :products
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
