Rails.application.routes.draw do
  get 'users/new'
  get 'users/account'
  get 'users/profile'
  root 'static_pages#home'
  resources :users
end
