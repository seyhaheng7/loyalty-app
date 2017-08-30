Rails.application.routes.draw do

  resources :receipts
  resources :stores
  resources :locations
  resources :companies
  resources :categories
  resources :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :users
      resources :categories, only: [:index, :show]
      resources :stores, only: [:index, :show]
    end
  end

  scope :auth do
    devise_for :users
  end

  root 'home#index'
end
