Rails.application.routes.draw do
  root 'toppages#index'

  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:create, :show, :edit, :update]
  resources :groups, only: [:new, :create, :show, :edit, :update]
end
