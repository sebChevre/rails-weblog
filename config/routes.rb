Rails.application.routes.draw do
  root to: redirect('/posts')

  resources :users
  resource :session, only: %i[new create destroy]

  resources :posts do
    resources :comments
  end
end
