Rails.application.routes.draw do

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get 'users/setting', to: 'users#setting', :as => 'settings'
  post 'users/setting', to: 'users#customize'
  get 'events/favorite', to: 'events#favorite', via:[:get], as: 'favorite'
  get '/ga' => 'application#ga'

  resources :users, only: [ :create, :new, :test ] #test action missing from controller?
  # resources :events, only: [ :index, :show ]

  scope controller: :events, path: 'events' do
    get '', action: :index, as: 'events_home'
    get 'new_event', action: :new, as: 'add_new_event'
    post 'new_event', action: :create
    get ':id', action: :show
  end

  resources :sessions, only: [ :create ]
  resources :password_resets

  root to: "home#index"

end
