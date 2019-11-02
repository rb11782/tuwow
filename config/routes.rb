Rails.application.routes.draw do
 root "wows#index"
 resources :wows, only: [:new, :create]
end
