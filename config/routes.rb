Rails.application.routes.draw do
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
  resources :companies
  resources :categories
  resources :users
  resources :rewards
  resources :stickers
  resources :sticker_groups

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :merchant do
      end

      namespace :customer do
        resources :receipts, only: [:index, :show, :create]
        resources :categories, only: [:index, :show]
        resources :stores, only: [:index, :show]
        resources :claimed_rewards
        resources :sticker_groups, only: [:index, :show]
        resources :near_by_customers, only: [:index]
        resources :operating_systems, only: [:create]
      end

    end
  end

  scope :auth do
    devise_for :users
  end

  mount_devise_token_auth_for 'Customer', at: 'api/v1/customer/auth', controllers: {
    sessions:  'overrides/devise_token_auth/customer/sessions',
    registrations:  'overrides/devise_token_auth/customer/registrations'
  }
  mount_devise_token_auth_for 'Merchant', at: 'api/v1/merchant/auth', controllers: {
    sessions:  'overrides/devise_token_auth/merchant/sessions'
  }

  root 'home#index'
end
