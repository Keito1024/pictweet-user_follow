Rails.application.routes.draw do


  resources :places
  get 'map/index'


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'tweets#index'
  resources :tweets do
    resources :comments, only: [:create]
  end
  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end
  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]
  resources :users, only: [:show]
end
