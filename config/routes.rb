Rails.application.routes.draw do

  namespace :public do
    get 'inquiries/index'
    get 'inquiries/confirm'
    get 'inquiries/thanks'
  end
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
    get 'users/search' => 'users#search', as: 'user_search'
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'users_unsubscribe'
    patch '/users/:id/withdraw' => 'users#withdraw', as: 'users_withdraw'
    resources :users, only: [:show, :edit, :update] do
      get 'health_logs/memo' => 'health_logs#memo'
      get 'health_logs/graph' => 'health_logs#graph'
      get 'health_logs/calendar' => 'health_logs#calendar'
      get 'health_logs/search' => 'health_logs#search'
      resources :health_logs

      resource :relationships, only: [:create, :destroy] do
        get 'followings' => 'relationships#followings'
        get 'followers' => 'relationships#followers'
      end

      resources :notifications, only: [:index]

      get   'inquiries'         => 'inquiries#index'
      post  'inquiries/confirm' => 'inquiries#confirm'
      post  'inquiries/thanks'  => 'inquiries#thanks'
    end

    get 'posts/search' => 'posts#search', as: 'post_search'
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end

    resources :chats, only: [:show, :create]

    get 'helps/post_method' => 'helps#post_method'
    get 'helps/log_method' => 'helps#log_method'
    resources :helps, only: [:index]


  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy]
    resources :post_comments, only: [:index, :show, :destroy]
  end

end
