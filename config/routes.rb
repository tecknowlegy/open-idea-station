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
      get "mark-all-as-read/:id", to: "notifications#mark_as_read_js"
    end
  end

  # External services authentication
  get "/auth/:provider/callback" => "users#omniauth_user"
  get "/auth/failure", to: redirect("/users/new")

  resources :users, only: %i[new create]
  post "users/create_omniauth_session", to: "users#create_omniauth_session", as: "omniauth_session"

  resources :sessions, only: %i[index new create destroy] do
    member do
      delete :revoke
    end
    collection do
      delete :revoke_all
    end
  end
end
