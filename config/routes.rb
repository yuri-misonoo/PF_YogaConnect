Rails.application.routes.draw do

  get root to: 'homes#top'

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  devise_for :admins, controllers: {
    sessions:      'admins/sessions'
  }

  scope module: :public do
    resources :users, only: [:new, :create, :show, :edit, :update] do
      resources :health_logs
      get 'health_logs/memo' => 'health_logs#memo'
      get 'health_logs/graph' => 'health_logs#graph'
      get 'health_logs/calender' => 'health_logs#calender'
    end
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :edit, :update, :destroy]
    end
    resources :notification, only: [:index]
  end

  namespace :admin do
    resources :users, only: [:index]
    resources :posts, only: [:index, :show, :destroy]
    resources :post_comments, only: [:index, :show, :destroy]
  end

end
