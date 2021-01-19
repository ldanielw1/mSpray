Rails.application.routes.draw do

  # Dashboard routes
  resource :dashboard, only: [] do
    get :view
  end
  root to: "dashboard#view"

  # Worker routes
  resource :workers, only: [] do
    get  :view
    get  :view_reports
    get  :sp1_form
    get  :sp2_form
    get  :sp3_form
    post :edit
    post :delete
  end

  # Data routes
  resource :spray_data, only: [] do
    get  :view
    post :edit
    post :delete
  end
  resource :malaria_reports, only: [] do
    get  :view
    post  :add
    post :edit
    post :delete
  end
  resource :future_spray_locations, only: [] do
    get  :view
    post  :add
    post :edit
    post :delete
  end

  # Admin routes
  resource :admin, only: [] do
    post :delete_user
    post :change_permissions
    get  :site_permissions
  end

  # Session routes
  resources :sessions , only: [:create, :destroy, :login]
  get 'session/create',                to: 'sessions#create'
  get 'auth/failure',                  to: redirect('/')
  get 'signout',                       to: 'sessions#destroy', as: 'signout'
  get 'signin',                        to: 'sessions#login',   as: 'signin'
end
