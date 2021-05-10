Rails.application.routes.draw do

  get 'reservations/confirm'
  get 'reservations/show'
  get 'reservations/index'
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: [:create, :update, :destroy] do
    member do
      get 'account', 'profile', 'reserving'
      patch 'account_update'
    end
  end  

  resources :rooms do
    member do
      get 'registered'
    end
  end

  resources :reservations, only: [:create, :destroy] do
    collection do
      post :confirm
    end
  end
end
