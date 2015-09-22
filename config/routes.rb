Rails.application.routes.draw do
  root 'welcome#show'

  get '/auth/twitter', as: :login

  get '/logout', as: :logout, to: 'sessions#destroy'

  get '/auth/twitter/callback', to: 'sessions#create'

  resources :users, except: [:destroy]
end
