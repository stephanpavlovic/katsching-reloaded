require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'
  # Defines the root path route ("/")
  root "pages#home"
  resources :groups, only: [:show]
  resources :users, only: [:show] do
    resources :transactions, only: [:create, :new]
  end
end
