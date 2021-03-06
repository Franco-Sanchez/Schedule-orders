Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/profile', to: 'users#show'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :stores, param: :name, only: :show

  resources :orders, only: %i[update]

  post '/', to: 'orders#create'

  root 'orders#new'
end
