Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'index#index', as: 'index'

  resources :ideas do
    get 'viewed'
    resources :comments
  end

  resources :notifications, only: [:index]

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  post '/login' => 'sessions#create_login'
  get '/logout' => 'sessions#logout'
  get '/profile' => 'users#user_profile'
end
