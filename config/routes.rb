Rails.application.routes.draw do
  devise_for :users
  resources :users, only:[:index]
  get "users/:id" => "users#main"
  get "users/:id/:year/:month" => "users#show"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  root 'home#top'
end
