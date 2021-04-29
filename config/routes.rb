Rails.application.routes.draw do
  # get 'users/new'
  # get 'users/account'
  # get 'users/profile'
  get '/signup', to: 'users#new'
  root 'static_pages#home'
  resources :users, only: [:create, :update, :destroy] do
    member do
      get 'account', 'profile'
    end
  end
end
