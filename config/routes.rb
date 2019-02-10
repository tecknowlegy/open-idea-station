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
    resources :viewers, controller: "idea_viewers", only: %i[index show]
    resources :comments
  end

  resources :notifications, only: [:index]

  get "/auth/:provider/callback" => "sessions#create_with_omniauth"
  get "/auth/failure", to: redirect("/users/new")

  resources :users, only: %i[new create]

  resources :sessions, only: %i[index new create destroy] do
    member do
      delete :revoke
    end
    collection do
      delete :revoke_all
    end
  end
end
