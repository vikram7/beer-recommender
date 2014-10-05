Rails.application.routes.draw do

  devise_for :users
  devise_for :models
  resources :beers
  root "welcome#index"

end
