Rails.application.routes.draw do
  root to: 'books#index'

  resources :books
  
  devise_for :users
  
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :books do
    post '/:id/reserve', to: 'books#reserve', as: 'reserve'
  end
end
