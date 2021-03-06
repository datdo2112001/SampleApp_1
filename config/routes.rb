# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'resgistration' },
             controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :microposts
  resources :relationships, only: %i[create destroy]
  resources :likes, only: %i[create destroy]
  resources :notifications
  resources :microposts do
    resources :comments
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
