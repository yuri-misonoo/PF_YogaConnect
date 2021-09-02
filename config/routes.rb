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




end
