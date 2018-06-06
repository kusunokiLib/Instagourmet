Rails.application.routes.draw do
  match '*path' => 'options_request#preflight', via: :options

  devise_for :user, only: []

  namespace :api, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resource :users, only: [:create]
  end

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
    post '/users/follow/:user_id', to: 'users#follow'
    post '/users/unfollow/:user_id', to: 'users#unfollow'
    get '/users/isfollowing/:user_id', to: 'users#following?'
    post '/users/favorite/:post_id', to: 'users#favorite'
    post '/users/unfavorite/:post_id', to: 'users#unfavorite'
    get '/users/isfavorite/:post_id', to: 'users#favorite?'

    resources :users, only: [:index, :show] do
        get :following, :followers
        get :favorite_posts
      resources :posts, only: [:index, :show, :create] do
      end
    end
  end

  root to: 'home#index'

end
