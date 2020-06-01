Rails.application.routes.draw do
  root 'toppages#index'

  get 'signup', to: 'users#new'
  resources :users, only: [:create, :show, :edit, :update]
end
