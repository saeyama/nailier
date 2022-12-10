Rails.application.routes.draw do
  devise_for :users
  root 'top#index'

  get 'privacy_policy', to: 'pages#privacy_policy', as: 'privacy_policy'
  get 'tos', to: 'pages#tos', as: 'tos'

  resources :inquiries, only: [:new, :create]
  get 'inquiries/thanks', to: 'inquiries#thanks'

  resources :designs

  namespace :api, format: 'json' do
    resources :designs
  end
end
