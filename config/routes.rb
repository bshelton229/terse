Terse::Application.routes.draw do
  root 'urls#index'
  resources :urls
  get '/auth/github/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
end
