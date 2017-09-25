require 'sidekiq/web'
Rails.application.routes.draw do

  resources :customer_locations, only: :index

  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'

  resources :claimed_rewards do
    member do
      patch :reject
      patch :approve
    end
  end

  resources :receipts do
    member do
      patch :reject
      patch :approve
    end
  end

  resources :stores
  resources :locations
  resources :customers
  resources :companies
  resources :categories
  resources :users
  resources :merchants
  resources :rewards
  resources :stickers
  resources :sticker_groups
  resources :settings

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :merchant do
      end

      namespace :customer do
        resources :confirmations, only: [] do
          put :confirm, on: :collection
        end
        resources :digits, only: [] do
          put :send_digit, on: :collection
        end
        resources :receipts, only: [:index, :show, :create]
        resources :categories, only: [:index, :show]
        resources :stores, only: [:index, :show]
        resources :claimed_rewards, only: [:create]
        resources :rewards, only: [:index, :show]
        resources :sticker_groups, only: [:index, :show]
        resources :near_by_customers, only: [:index]
        resources :operating_systems, only: [:create]
      end

    end
  end

  scope :auth do
    devise_for :users, controllers: {
      sessions:  'overrides/devise/sessions'
    }
  end

  mount_devise_token_auth_for 'Customer', at: 'api/v1/customer/auth', controllers: {
    sessions:  'overrides/devise_token_auth/customer/sessions',
    registrations:  'overrides/devise_token_auth/customer/registrations'
  }
  mount_devise_token_auth_for 'Merchant', at: 'api/v1/merchant/auth', controllers: {
    sessions:  'overrides/devise_token_auth/merchant/sessions',
    registrations:  'overrides/devise_token_auth/merchant/registrations'
  }

  root 'home#index'
end
