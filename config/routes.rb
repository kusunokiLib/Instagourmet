Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get :following, :followers
      get :favorite_posts
      post 'follow/:followed_id', to: 'users#follow' , as: 'follow'
      post 'unfollow/:followed_id', to: 'users#unfollow', as: 'unfollow'
    end
    resources :posts
  end
end
