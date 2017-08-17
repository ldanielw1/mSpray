Rails.application.routes.draw do
  get 'home', to: 'home#show', as: 'home'

  # User routes
  resources :users, only: [:edit, :update]

  # Session routes
  resources :sessions , only: [:create, :destroy]
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  # Set home page
  root to: "home#show"
end
