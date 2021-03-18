Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'

  authenticated :user do
    resources :biens do
      resources :loyers, only: [:create, :destroy]
      resources :locataires, only: [:create, :destroy]
      resources :frais_recurrents, only: [:create, :destroy]
      resources :depenses, only: [:create, :destroy]
    end
  end
end
