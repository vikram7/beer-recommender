Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:index, :show, :update] do
    resources :recommendations, only: [:index]
  end

  devise_for :models
  resources :beers do
    resources :reviews
  end
  root "welcome#index"

end
