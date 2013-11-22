Terse::Application.routes.draw do
  root 'urls#index'
  resources :urls
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/auth/github/callback', to: 'sessions#create'
  # Development omniauth-github
  post '/auth/developer/callback', to: 'sessions#developer_strategy' unless Rails.env.production?

  get '*slug', to: 'urls#resolve'
end
