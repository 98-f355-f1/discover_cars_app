Rails.application.routes.draw do
  root 'sessions#new'

  resources :users, only: %i[new create]

  get 'login',      to: 'sessions#new'
  post 'login',     to: 'sessions#create'
  get 'welcome',    to: 'sessions#welcome'

  resources 'api', only: [] do
    post 'post', to: 'api/environment#post', on: :collection
  end

  get 'api/environment', to: 'api/environment#environment'
  get 'api/headers', to: 'api/environment#headers'
end
