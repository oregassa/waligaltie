Rails.application.routes.draw do
devise_for :users
resources  :posts
root               'pages#home'
get 'contact', to: 'pages#contact'
get 'about',   to: 'pages#about'
end
