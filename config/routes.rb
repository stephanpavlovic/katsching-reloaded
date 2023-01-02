require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'
  # Defines the root path route ("/")
  root "pages#home"
  get "/clear", to: "pages#clear", as: :clear
  resources :groups, only: [:show]
  resources :users, only: [:show] do
    resources :transactions
  end
  resources :repetitions, only: [:create, :new, :edit, :update]
end
