Certipedia::Application.routes.draw do
  resources :certificates 
  # map '/' to be a redirect to '/certificates'
  root :to => redirect('/certificates')

  resources :users, only: [:new, :create, :index, :show]
  resources :sessions, only: [:new, :create]
  resources :bookmarks, only: [:new]

end
