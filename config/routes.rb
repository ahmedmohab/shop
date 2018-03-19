Rails.application.routes.draw do
  
  resources :items
    devise_for :users
    resources :carts
  resources :users
  resources :products
  resources :categories
  resources :orders
    post '/users/:id/edit' => 'users#edit', :as => 'user_edit'
    root :to => 'products#index'
    get '/add_item/:product_id' => 'items#add_item', :as => 'add_item'
    get 'index' => "products#index", :as => 'go_products'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
