Rails.application.routes.draw do

  resources :articles, only: [:index]
  resources :search_analytics, only: [:index]

  # Defines the root path route ("/")
  root "articles#index"
end
