Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :users do
  #   member do
  #     get :following, :followers
  #     get :favorite_posts
  #     post 'follow', to: 'users#follow'
  #     post 'unfollow', to: 'users#unfollow'
  #   end
  #   resources :posts do
  #     post 'favorite', to: 'users#favorite'
  #     post 'unfavorite', to: 'users#unfavorite'
  #   end
  # end

  # API
  namespace :api, format: 'json' do
    resources :users, only: [:index, :show] do
        get :following, :followers
        get :favorite_posts
      resources :posts, only: [:index, :show] do
      end
    end
  end

  get '*path', to: 'home#index'
end
