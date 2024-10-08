# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    sessions: 'api/v1/authentication/sessions',
    registrations: 'api/v1/users/registrations',
    passwords: 'api/v1/users/passwords'
  }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :addresses, only: [:show]
      resources :users, only: [:destroy]
      resources :contacts
      resources :autocomplete_addresses, only: [:index]
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
