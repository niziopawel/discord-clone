# frozen_string_literal: true

Rails.application.routes.draw do
  resources :servers do
    resources :channels, only: %i[new create], module: :servers
  end

  resources :channels, only: %i[show edit update create destroy] do
    resources :messages, only: %i[new create], module: :channels
  end

  resources :messages, only: %i[show edit update create destroy]

  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sing_out: 'logout'
             }

  devise_scope :user do
    authenticated { root to: 'servers#index', as: :authenticated_root }
    unauthenticated { root to: 'devise/sessions#new', as: :unauthenticated_root }
  end
end

