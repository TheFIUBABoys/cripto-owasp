Rails.application.routes.draw do

  root 'welcome#index'

  get :unauthorized, to: 'error#unauthorized'

  resources :users, only: [:show, :new, :create]
  resources :sessions, only: [:show, :new, :create, :destroy]
  resources :sql_injection_objects do
    member do
      delete :destroy_protected
    end
  end

end
