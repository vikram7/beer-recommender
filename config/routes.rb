Rails.application.routes.draw do

  devise_for :users
  devise_for :models
  resources :beers do
    resources :reviews
  end
  root "welcome#index"

end
