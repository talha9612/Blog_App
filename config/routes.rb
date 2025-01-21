Rails.application.routes.draw do
  devise_for :users
  # get "posts/index"
  # get "posts/show"
  # get "posts/new"
  # get "posts/create"
  # get "posts/edit"
  # get "posts/update"
  # get "posts/destroy"
  root "posts#index"
  resources :posts
  #  get "/test/:id", to: "posts#show"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  # get 'posts/:id', to: 'posts#show', as: 'post'
  # patch 'posts/:id', to: 'posts#update'


  resources :articles
end
