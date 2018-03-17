Rails.application.routes.draw do
  resources :carts
  resources :users
  resources :products
  resources :categories
  resources :orders
    root :to => 'products#index'
    post '/add_to_cart/:product_id' => 'cart#add_to_cart', :as => 'add_to_cart'
    get 'index' => "products#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
