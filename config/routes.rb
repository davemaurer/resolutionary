Rails.application.routes.draw do
  root 'welcome#show'

  get '/auth/twitter', as: :login

  get '/auth/twitter/callback', to: 'sessions#create'

  get '/logout', as: :logout, to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#show'

  resources :users, only: [:show]

  put '/resolutions/:id/complete', as: :complete, to: 'resolutions#complete'
  put '/resolutions/:id/again', as: :again, to: 'resolutions#again'

  resources :resolutions, except: [:index] do
    resources :reminders, except: [:index]
    resources :tweets, only: [:create]
    put '/goals/:id/goal_complete', as: :goal_complete, to: 'goals#goal_complete'
    resources :goals, except: [:index]
  end

  post 'notifications/notify', to: 'notifications#notify'
end
