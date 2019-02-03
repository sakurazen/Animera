Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create, :edit]
  
  resources :animes, only: [:index, :show, :new, :create, :destroy]
  resources :reviews, only: [:index, :show, :new, :create, :destroy, :update]
end