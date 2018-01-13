Rails.application.routes.draw do
  get 'user/signup'

  get 'user/login'

  get 'user/edit_profile'

  root to: "index#index", as: "index"
  resources :ideas
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
