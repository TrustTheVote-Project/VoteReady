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
    registrations: 'user/registrations',
    confirmations: 'user/confirmations',
    passwords: 'user/passwords',
    unlocks: 'user/unlocks'
  }
  
  devise_scope :user do
    get '/', to: 'user/registrations#new', as: :register
  end
  
  resources :users, only: [:show, :edit, :update] do
    member do
      get :welcome
      get :history
    end
  end
  
  resources :voter_record_updates, only: :show
  
  root "user/registrations#new"
  
end
