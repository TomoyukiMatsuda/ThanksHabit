Rails.application.routes.draw do
  root 'toppages#index'

  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:create, :show, :edit, :update]

  resources :groups, only: [:new, :create, :show, :edit, :update] do
    member do
      get :search_user
    end
  end

  resources :group_users, only: [:create, :destroy] do
    member do
      get :invite
    end
  end
end
