Rails.application.routes.draw do

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get 'users/setting', to: 'users#setting', :as => 'settings'
  get 'users/new' => 'users#new', :as => "new_user"
  post 'users/setting', to: 'users#customize'
  get 'events/favorite', to: 'events#favorite', via:[:get], as: 'favorite'
  get '/ga' => 'application#ga'

  resources :users, only: [ :create, :test ] #test action missing from controller?
  resources :events, only: [ :index, :show ]
  resources :sessions, only: [ :create ]
  resources :password_resets

  root to: "home#index"

end
