Rails.application.routes.draw do
  root 'home#index'
  get 'users/setting', to: 'users#setting', :as => 'new_settings'
  post 'users/setting', to: 'users#customize'
  post 'users/sign_up', to: 'users#create'
  # post 'users/new', to: 'users#create'
  get 'events/favorite', to: 'events#favorite', via:[:get], as: 'favorite'
  delete 'users/sign_out', to: 'users#destroy'

  resources :events, only: [:index, :show]


  devise_for :users do
    get 'users/sign_out' => 'devise/sessions#destroy'
    post 'users/passwords' => 'devise/sessions#destroy'
    get 'users/sign_up' => 'devise/registrations#new', as: 'new_user_registration'
    # post 'users/sign_up' => 'devise/registrations#create'
    # post '/sign_up' => 'devise/registrations#create'
  end

  # devise_for :users

  # devise_for :user do
  #   get '/sign_up' => 'devise/registrations#new', :as => 'new_user_registration'
    # post '/sign_up' => 'devise/registrations#create'
  # end 

end