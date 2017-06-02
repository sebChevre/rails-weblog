Rails.application.routes.draw do
  root 'home#show'

  resources :users, only: %i[new create]
  resource :session, only: %i[new create destroy]

  resources :posts, only: %i[show] do
    resources :comments, only: %i[create]
  end

  namespace :admin do
    root to: redirect('/admin/posts')
    resources :users
    resources :posts do
      resources :comments
    end
  end
end
