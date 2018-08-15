Rails.application.routes.draw do
  get 'home', to: 'home#show', as: 'home'

  # User routes
  resources :users, only: [:edit, :update]

  # Admin routes
  resource :admin, only: [] do
    post :change_permissions
    get :site_permissions
  end

  # Data routes
  resource :spray_data, only: [] do
    get :view
  end

  # Worker routes
  resource :workers, only: [] do
    get :view
  end

  # Session routes
  resources :sessions , only: [:create, :destroy, :login]
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'signin', to: 'sessions#login', as: 'signin'

  resource :home, only: [:show]

  root to: "home#show"
end
