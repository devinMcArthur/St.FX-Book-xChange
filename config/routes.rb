Rails.application.routes.draw do
  get 'book_feed/show'

  get 'password_resets/new'

  get 'password_resets/edit'

  get '/conversations' => 'conversations#index'

  root 'static_pages#home'
  get    '/help'   => 'static_pages#help'
  get    '/about'  => 'static_pages#about'
  get    '/signup' => 'users#new'
  post   '/signup' => 'users#create'
  get    '/login'  => 'sessions#new'
  post   '/login'  => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get    '/books'  => 'books#show'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :books,               only: [:create, :destroy]
  resources :conversations do
    resources :messages
  end
end
