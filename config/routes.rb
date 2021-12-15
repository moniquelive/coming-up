Rails.application.routes.draw do
  root 'ideas#index'

  resources :ideas

  get 'auth/twitch/callback', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy', as: :session_destroy
end
