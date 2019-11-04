Rails.application.routes.draw do
  devise_for :users
  root "wows#index"
  resources :wows do
    resources :locations, only: :create
  end
  # resources :wows, only: [:new, :create, :show, :edit, :update, :destroy]
end
