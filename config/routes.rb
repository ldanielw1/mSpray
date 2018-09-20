Rails.application.routes.draw do

  # Dashboard routes
  resource :dashboard, only: [] do
    get :view
  end
  root to: "dashboard#view"

  # Worker routes
  resource :workers, only: [] do
    post :edit
    post :delete
    get  :view
  end

  # Data routes
  resource :spray_data, only: [] do
    post :edit
    post :delete
    get  :view
  end
  resource :malaria_reports, only: [] do
    get  :add
    post :edit
    post :delete
    get  :view
  end
  resource :future_spray_locations, only: [] do
    get  :add
    post :edit
    post :delete
    get  :view
  end

  # User routes
  resources :users, only: [] do
    get  :edit
    get  :update
  end

  # Admin routes
  resource :admin, only: [] do
    post :delete_user
    post :change_permissions
    get  :site_permissions
  end

  # Session routes
  resources :sessions , only: [:create, :destroy, :login]
  get 'auth/:provider/callback',       to: 'sessions#create'
  get 'auth/failure',                  to: redirect('/')
  get 'signout',                       to: 'sessions#destroy', as: 'signout'
  get 'signin',                        to: 'sessions#login',   as: 'signin'
end
