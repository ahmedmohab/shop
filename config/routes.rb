Rails.application.routes.draw do
  resources :users
  resources :products
  resources :categories
  resources :orders
    root :to => 'products#index'
    
    get 'index' => "products#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
