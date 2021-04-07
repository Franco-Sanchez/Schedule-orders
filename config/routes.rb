Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  post '/singup', to: 'users#create'
  get '/profile', to: 'users#show'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#delete'

  get '/stores/:name', to: 'stores#show'

  resources :orders, only: %i[new create]

  root 'orders#new'
end
