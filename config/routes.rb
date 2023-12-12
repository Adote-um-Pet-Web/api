# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'v1/auth/user'

  namespace :v1 do
    namespace :admin do
      get 'home' => 'home#index'
    end
  end
end
