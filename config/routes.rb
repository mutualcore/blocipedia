Rails.application.routes.draw do
  resources :charges, only: [:new, :create, :update]
  resources :wikis

  devise_for :users

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
