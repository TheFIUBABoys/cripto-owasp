Rails.application.routes.draw do

  root 'welcome#index'

  get :unauthorized, to: 'error#unauthorized'

  resources :users, only: [:show, :new, :create]
  resources :sessions, only: [:show, :new, :create, :destroy]

end
