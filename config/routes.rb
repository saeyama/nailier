Rails.application.routes.draw do
  root 'top#index'
  resources :inquiries, only: [:new, :create]
  get 'inquiries/thanks', to: 'inquiries#thanks'

  resources :designs, only: %i(index show)

  namespace :api, format: 'json' do
    resources :designs, only: %i(index show)
  end
end
