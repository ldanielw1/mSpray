Rails.application.routes.draw do

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
    get :add
    post :edit
    post :delete
    get  :view_reports
    get  :view
    get  :sp1_form
    get  :sp2_form
    get  :sp3_form
  end

  # User routes
  resources :users, only: [:edit, :update]

  # Admin routes
  resource :admin, only: [] do
    post :delete_user
    post :change_permissions
    get  :site_permissions
  end

  # Session routes
  resources :sessions , only: [:create, :destroy, :login]
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'signin', to: 'sessions#login', as: 'signin'

  # Dashboard routes
  resource :dashboard, only: [:show] do
    get :add_future_spray_location, to: "dashboard#add_future_spray_location"
    get :delete_future_spray_location, to: "dashboard#delete_future_spray_location"
    get :edit_future_spray_location, to: "dashboard#edit_future_spray_location"
  end

  root to: "dashboard#show"
end
