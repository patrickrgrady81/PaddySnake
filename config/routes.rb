Rails.application.routes.draw do
  root to: "pages#home"


  namespace :api, constraints: {format: :json}, defaults: {format: :json} do
    namespace :v1 do
      resources :scores, only: [:index, :show, :create]
      resources :users, only: [:index]

      post "users/login", to: "users#login"
    end
  end
end
