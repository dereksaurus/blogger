Blogger::Application.routes.draw do
  root to: 'articles#index'
  resources :articles do
    resources :comments
  end

  resources :tags
  resources :authors
  resources :author_sessions, only: [ :new, :create, :destroy ]
  match 'login' => 'author_sessions#new'
  match 'logout' => 'author_sessions#destroy'
end
