Rails.application.routes.draw do
  root "artisans#new"

  resource :artisans
end
