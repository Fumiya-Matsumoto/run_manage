Rails.application.routes.draw do
  devise_for :users
  resources :users, only:[:index]
  get "users/:id" => "users#main"
  get "users/:id/:year/:month" => "users#show"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  post "posts/:id/destroy_show" => "posts#destroy_show"
  post "posts/:id/destroy_main" => "posts#destroy_main"
  root 'home#top'
end
