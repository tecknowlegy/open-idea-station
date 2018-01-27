Rails.application.routes.draw do

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'user/signup'

  get 'user/login'

  get 'user/edit_profile'

  root to: "index#index", as: "index"
  
  resources :ideas do
    get 'viewed'
  end
end
