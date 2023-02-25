require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'
  # Defines the root path route ("/")
  root "pages#home"
  get "/clear", to: "pages#clear", as: :clear
  get '/login/:token', to: 'login#show', as: :login
  get '/logout', to: 'login#destroy', as: :logout
  resources :groups, only: [:new, :create, :show] do
    get :user_row, on: :collection
  end
  resources :users, only: [:show] do
    resources :transactions
    post :search, on: :collection
    get :repetitions, on: :member
  end
  resources :repetitions, only: [:create, :new, :edit, :update, :destroy]
  resources :transactions, only: [:show, :index] do
    get :balance, on: :collection
  end
end
