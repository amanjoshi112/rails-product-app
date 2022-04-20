Rails.application.routes.draw do
  get 'orders/index'
  #devise_for :users
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #root "products#index"
  get "/cart" => "cart#show"
  get "/cart/add/:id" => "cart#add", :as => :add_to_cart
  post "/cart/remove/:id" => "cart#remove", :as => :remove_from_cart
  post "/cart/checkout" => "cart#checkout", :as => :checkout
  #get "/history/:id" => "history#index", :as => :history

  get "signup" => "users#new", :as => :signup
  get "logout" => "sessions#destroy", :as => :logout
  get "login" => "sessions#new", :as => :login
  
  resources :sessions
  resources :users do 
    resources :orders
  end
  #resources :orders
  resources :products

  # Defines the root path route ("/")
  root "products#index"

  # get "/products", to: "products#index"
  # get "/products/:id", to: "products#show"
end
