Rails.application.routes.draw do
  root 'top#index'
  resources :inquiries, only: [:new, :create]
  get 'inquiries/thanks', to: 'inquiries#thanks'
end
