Rails.application.routes.draw do


devise_for :users
resources :contacts, only: [:new, :create]

resources  :posts do 
  resources :comments
end

get "/home" => "pages#home"
get "/about" => "pages#about"

root 'posts#index'
end
