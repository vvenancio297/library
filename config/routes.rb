Rails.application.routes.draw do
  root to: 'books#index'

  resources :books, except: %i[show destroy] do
    resources :reservations, only: %i[new edit update create]
  end

  resources :reservations, only: :index
  
  devise_for :users
  
  get 'up' => 'rails/health#show', as: :rails_health_check
end
