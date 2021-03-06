Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  root to: 'users#index'

  resources :availabilities
  resources :schedules
  resources :subjects
  resources :grades
  resources :bookings
  post 'subjects/bulk', to: 'subjects#bulk'
  post 'schedules/bulk', to: 'schedules#bulk'

  # resources :bookings, only: %i[index edit update] do
  #   get :confirmation, on: :member
  # end

  resources :users, only: %i[index show] do
    resources :bookings, only: %i[create]
    resources :reviews, only: %i[create]
  end
end
