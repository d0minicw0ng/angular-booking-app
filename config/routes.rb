Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/auth'
  root to: "application#index"
  get "*path" => "application#index"

  namespace :api do
    namespace :v1 do
      resources :companies, only: [:create]
    end
  end
end
