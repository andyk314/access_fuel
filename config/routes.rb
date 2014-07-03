Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'users/new', to: 'users#new'
  post 'users/new', to: 'users#create'
  get 'events/favorite', to: 'events#favorite', via:[:get], as: 'favorite'
  resources :events, only: [:index, :show]

  # get 'events/accordian', to: 'events#accordian', via:[:get], as: 'accordian'

  # devise_for :user do
  #   get '/sign_up' => 'devise/registrations#new', :as => 'new_user_registration'
  #   post '/sign_up' => 'devise/registrations#create', :as => 'user_registration'
  # end 

end