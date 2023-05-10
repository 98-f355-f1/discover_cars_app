Rails.application.routes.draw do
  root 'sessions#new'

  resources :users, only: %i[new create]

  get 'login',      to: 'sessions#new'
  post 'login',     to: 'sessions#create'
  get 'welcome',    to: 'sessions#welcome'

  get 'api/post', to: 'api/post#new_post'
  get 'api/environment', to: 'api/environment#environment'
  get 'api/headers', to: 'api/headers#headers'
end
