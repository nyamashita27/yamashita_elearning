Rails.application.routes.draw do
 
  get '/words', to: 'words#index'
  
  get '/categories', to: 'categories#index'
  namespace :admin do
    get 'home', to: 'static_pages#home'
    resources :users, only: [:index, :update, :destroy]
    resources :categories do
      resources :words
    end
  end

  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  # For follow and unfollow
  resources :relationships, only: [:create, :destroy]

  resources :lessons, only: [:create, :show] do
    resources :answers, only: [:new, :create]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
