Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index'
  resources :tweets do
    resources :comments, only: [:create]
  end
  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]
  resources :users, only: [:show]
end
