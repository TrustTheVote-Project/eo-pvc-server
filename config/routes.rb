Rails.application.routes.draw do
  devise_for :users
  
  resources :voter_record_searches, only: [:index, :create]
  resources :users
  
  root to: "voter_record_searches#index"
  
end
