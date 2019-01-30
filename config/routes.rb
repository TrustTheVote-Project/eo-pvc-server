Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/demo_admin', as: 'rails_admin'
  devise_for :users
  
  resources :voter_record_searches, only: [:index, :create]
  resource :user do
    member do
      get :confirm_registration
      get :start_online_registration
      get :edit_notifications
      get :edit_contacts
      get :fake_eo_registration
    end
  end
  
  resources :notifications, only: [:index, :show] do
    collection do
      get :check_new
    end
    member do
      get :dismiss
    end
  end
  
  root to: "voter_record_searches#index"
  
end
