Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' , to: 'homes#about', as: 'homes_about'

  devise_for :users

  resources :homes, only:[:home, :about]
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end