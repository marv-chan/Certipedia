Certipedia::Application.routes.draw do
  resources :certificates
  # map '/' to be a redirect to '/certificates'
  root :to => redirect('/certificates')

  resources :users, only: [:new, :create, :index, :show]
  resources :sessions, only: [:create]
  get '/login', to: 'sessions#login', as: 'login'
  get '/logout', to: 'sessions#logout', as: 'logout'
  resources :bookmarks, only: [:create, :destroy]

end
