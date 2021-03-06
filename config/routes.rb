Rails.application.routes.draw do
  root to: "pages#home"

  namespace :api, constraints: {format: :json}, defaults: {format: :json} do
    namespace :v1 do
      resources :scores, only: [:index, :show, :create]
      resources :users, only: [:index]
      resources :sessions, only: [:create]
      resources :registrations, only: [:create]

      post "/login", to: "sessions#create"
      post "/logout", to: "sessions#destroy"
      post "/signup", to: "users#create"
      get "/check", to: "sessions#check"
    end
  end
end
