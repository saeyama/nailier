Rails.application.routes.draw do
  authenticated :user do
    root to: 'designs#index', as: :authenticated_user_root
  end
  root 'top#index'

  get 'privacy_policy', to: 'pages#privacy_policy', as: 'privacy_policy'
  get 'tos', to: 'pages#tos', as: 'tos'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get 'users/thanks', to: 'users/registrations#thanks'
    get 'users/unsubscribe', to: 'users/registrations#unsubscribe'
    get 'users/withdrawal', to: 'users/registrations#withdrawal'    
  end

  resource :my_account, only: :show

  resources :inquiries, only: [:new, :create] do
    get 'thanks', on: :collection
  end

  resources :designs

  namespace :api, format: 'json' do
    resources :designs
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?  
end
