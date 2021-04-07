Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  post '/singup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#delete'

  resources :orders, only: %i[new create]

  root 'orders#new'
end
