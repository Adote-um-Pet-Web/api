# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'v1/auth/user'

  namespace :v1 do
    namespace :admin do
      get 'home' => 'home#index'
      resources :users
    end
    resources :pets, only: %i[show create update destroy] do
      collection do
        get 'my_pets'
        get 'my_pets/:id', to: 'pets#show_my_pet'
        get 'availables'
        get 'availables/:id', to: 'pets#show_available'
      end
    end
    resources :adoptions
  end
end
