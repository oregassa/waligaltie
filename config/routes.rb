Rails.application.routes.draw do
devise_for :users
resources  :posts do 
  resources :comments
end

root 'home'              'posts#index'
end
