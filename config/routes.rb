Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create]
      resources :likes, only: [:create]
    end
  end
  namespace :api do
    resources :users do
      resources :posts, only: [:index] do
        resources :comments, only: %i[index create]
      end
    end
  end
end
