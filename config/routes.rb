Rails.application.routes.draw do

  get root to: 'homes#top'
  get 'homes/about' => 'homes#about'

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  devise_for :admins, controllers: {
    sessions:      'admins/sessions'
  }

  scope module: :public do
    get 'users/:id/new' => 'users#new', as: 'new_user'
    patch 'users/:id/new' => 'users#create', as: 'user_update'
    resources :users, only: [:show, :edit, :update, :destroy] do
      resources :health_logs
      get 'health_logs/memo' => 'health_logs#memo'
      get 'health_logs/graph' => 'health_logs#graph'
      get 'health_logs/calender' => 'health_logs#calender'
    end
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :notification, only: [:index]
  end

  namespace :admin do
    resources :users, only: [:index]
    resources :posts, only: [:index, :show, :destroy]
    resources :post_comments, only: [:index, :show, :destroy]
  end

end
