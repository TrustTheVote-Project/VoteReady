Rails.application.routes.draw do
  namespace :admin do
    resources :users do
      member do
        get :simulate_voter_record_change
      end
    end
    resources :voter_records    
    resources :voter_record_updates    
    root to: "users#index"
  end
  devise_for :users, controllers: {
    registrations: 'user/registrations'
  }
  
  resources :users, only: [:show] do
    member do
      get :welcome
    end
  end
  
  root to: 'user/registrations#new'
  
end
