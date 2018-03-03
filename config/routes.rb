Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'users#new_login'
  post '/login' => 'sessions#create_login'
  get '/logout' => 'sessions#logout'

  root to: 'index#index', as: 'index'

  resources :ideas do
    get 'viewed'
    resources :comments
  end

  resources :notifications, only: [:index]
end
