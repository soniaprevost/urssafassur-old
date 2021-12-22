Rails.application.routes.draw do
  root "artisans#new"

  resources :artisans, only: [:new, :create, :show]
end
