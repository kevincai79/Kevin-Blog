Rails.application.routes.draw do
  root 'pages#home'
  get '/about', to: 'pages#about'

  resources :articles do
    resources :comments, shallow: true
  end

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, except: [:new]
  resources :categories
end
