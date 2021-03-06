Rails.application.routes.draw do
  
  resources :items
    devise_for :users
    get '/carts/checkout' => "carts#checkout", :as => 'check_me_out'
    get 'carts/confirm' => "carts#confirm"
    get 'products/all' => "products#all", :as => 'all_products'
    get '/users/admin' => "users#admin", :as => 'users_admin'
    post 'users/new' => 'users#new'   
    resources :carts
  resources :users
  resources :products
  resources :categories
  resources :orders
    get '/order/:id/edit' =>'orders#edit', :as => 'order_edit' 
    #post '/users/:id/edit' => 'users#edit', :as => 'user_edit'
    get 'users/:id/makeadmin' => 'users#makeadmin', :as => 'make_admin'
    post '/items/:id' => 'items#update', :as => 'item_update'
    root :to => 'products#index'
    get '/add_item/:product_id' => 'items#add_item', :as => 'add_item'
    
    get 'index' => "products#index", :as => 'default_path'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
