Rails.application.routes.draw do
  resources :locations
  resources :users

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :users
    end
  end

  scope :auth do
    devise_for :users
  end

  resources :users

  root 'home#index'
end
