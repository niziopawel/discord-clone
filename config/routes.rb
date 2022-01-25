# frozen_string_literal: true

Rails.application.routes.draw do
  resources :servers

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
