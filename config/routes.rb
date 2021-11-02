Certipedia::Application.routes.draw do
  resources :certificates
  # map '/' to be a redirect to '/certificates'
  root :to => redirect('/certificates')
end
