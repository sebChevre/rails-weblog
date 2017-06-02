Rails.application.routes.draw do
  root 'home#show'

  resources :users, only: %i[new create]
  resource :session, only: %i[new create destroy]

  resources :posts do
    resources :comments
  end
end
