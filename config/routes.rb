Rails.application.routes.draw do
  root 'welcome#show'

  get '/auth/twitter', as: :login

  get '/auth/twitter/callback', to: 'sessions#create'

  get '/logout', as: :logout, to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#show'

  resources :users, except: [:destroy]

  put '/resolutions/:id/complete', as: :complete, to: 'resolutions#complete'

  resources :resolutions do
    resources :tweets, only: [:create]
    put '/goals/:id/goal_complete', as: :goal_complete, to: 'goals#goal_complete'
    resources :goals
  end
end
