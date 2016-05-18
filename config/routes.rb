Rails.application.routes.draw do

get "/home" => "pages#home"
get "/about" => "pages#about"
get "/contact" => "pages#contact"

devise_for :users

resources  :posts do 
  resources :comments
end

root 'posts#index'
end
