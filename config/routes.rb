Rails.application.routes.draw do
  root 'top#index'
  get 'privacy_policy', to: 'pages#privacy_policy', as: 'privacy_policy'
  get 'tos', to: 'pages#tos', as: 'tos'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'users/thanks', to: 'users/registrations#thanks'
  end

  get 'users', to: 'users#show'

  resources :inquiries, only: [:new, :create]
  get 'inquiries/thanks', to: 'inquiries#thanks'

  resources :designs

  namespace :api, format: 'json' do
    resources :designs
  end
end
