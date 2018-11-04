Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => "/cable"
  root to: "index#index", as: "index"

  # FUTURE: API endpoints
  namespace :api, path: nil, defaults: { format: :json }, constraints: { subdomain: /^api(-\w+)?$/ } do
    resources :ideas do
      get "viewed"
      resources :comments
    end
  end

  resources :ideas do
    get "viewed"
    resources :comments
  end

  resources :notifications, only: [:index]

  get "/auth/:provider/callback" => "sessions#login_with_omniauth"
  get "/auth/failure", to: redirect("/signup")

  get "/signup" => "users#new"
  post "/signup" => "users#create"
  post "/login" => "sessions#login"
  get "/logout" => "sessions#logout"
end
