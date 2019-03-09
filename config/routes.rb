Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => "/cable"
  root to: "index#index", as: "index"

  # FUTURE: API endpoints
  # namespace :api, path: nil, defaults: { format: :json }, constraints: { subdomain: /^api(-\w+)?$/ } do
  #   resources :ideas
  # end

  resources :ideas do
    resources :viewers, controller: "idea_viewers", only: %i[index show]
    resources :comments
  end

  resources :categories

  resources :notifications, only: %i[index destroy] do
    collection do
      get "/recent", to: "notifications#show"
      get "mark-all-as-read/:user_id", to: "notifications#update"
    end
  end
  # Users
  resources :users, only: %i[index new create]
  # External services authentication
  resources :omniauth, only: %i[new create] do
    collection do
      post "session", to: "omniauths#update"
    end
  end
  get "/auth/:provider/callback" => "omniauths#new"
  get "/auth/failure", to: redirect("/users/new")
  # Create session
  resources :sessions, only: %i[index new create destroy] do
    member do
      delete :revoke
    end
    collection do
      delete :revoke_all
    end
  end
  # Email confirmation
  resources :email_confirmations, only: %i[create edit update], param: :token
end
