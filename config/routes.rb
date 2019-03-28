Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/demo_admin', as: 'rails_admin'
  devise_for :users
  
  resources :voter_record_searches, only: [:index, :create, :new]
  resource :user do
    member do
      get :confirm_registration
      get :start_online_registration
      get :new_registrant
      get :update_address
      get :edit_notifications
      get :edit_notifications_2
      get :edit_notifications_3      
      get :edit_notifications_4
      get :edit_notifications_advanced
      get :edit_contacts
      get :fake_eo_registration
      get :submit_fake_eo_registration
    end
  end
  
  resources :voting_options, only: :index do
    
  end
  
  resources :services, only: :index do
    collection do
      get :registration
      get :register_online
      get :register_same_day
      get :register_same_day_2
      get :register_same_day_3
      get :register_same_day_complete
      get :by_mail
      post :by_mail
      get :by_mail_special_ballot
      post :by_mail_special_ballot
      get :by_mail_tracker
      get :online_special_ballot
      get :online_special_ballot_2
      post :online_special_ballot_2
      get :online_special_ballot_complete
      post :online_special_ballot_complete
      get :sample_ballot
      get :sample_ballot_2
      post :sample_ballot_2
      get :dvic
      get :dvic_2
    end
  end
  
  resources :absentee_requests do
    member do
      get :step_1
      get :step_2
      get :step_3
      get :step_4
      get :complete
    end
  end
  
  resources :notifications, only: [:index, :show] do
    collection do
      get :check_new
    end
    member do
      get :dismiss
      get :cancel
    end
  end
  
  resource :information, only: :show
  
  resource :splash, only: :show
  resource :legal, only: :show, controller: "legal"
  
  root to: "splash#show"
  
  #root to: "voter_record_searches#index"
  
end
