Rails.application.routes.draw do
 root 'home#index'

devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, controllers:     {omniauth_callbacks: "omniauth_callbacks"}

resources :answers
resources :users, only: [:new, :create]

resources :questions do
   resources :answers #-> domain.com/questions/1/answers/new
end

resources :events, only: [:index, :new, :show, :update] do
   patch ":id", action: :index
   collection do
       get :favorite
       get "question/:id", action: :question
   end
end

get 'users/new', to: 'users#new'
post 'users/new', to: 'users#create'
get 'events/favorite', to: 'events#favorite', via:[:get], as: 'favorite'
post 'events/:id' => 'events#update'
get 'answers/new' => 'answers#new'
# get 'answers/:id' => 'answers#show'

end