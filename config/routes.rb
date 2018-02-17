Rails.application.routes.draw do

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'users#new_login'
  post '/login' => 'users#create_login'
  get '/logout' => 'users#logout'
  # put 'users/edit_profile' => 'users#edit_profile'
  # resources :users

  root to: "index#index", as: "index"
  
  resources :ideas do
    get 'viewed'
    resources :comments
  end
  
  resources :notifications, only: [:index]
end
