Rails.application.routes.draw do

  resources :beers
  root "beers#index"

end
