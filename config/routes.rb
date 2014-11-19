Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/auth'
  root to: "application#index"

  namespace :api do
    namespace :v1 do
      resources :companies, only: [:create]
      get "employees", to: "users#employees"
      get "customers", to: "users#customers"
      resources :appointments, only: [:create, :index, :update, :destroy]
    end
  end

  get "*path" => "application#index"
end
