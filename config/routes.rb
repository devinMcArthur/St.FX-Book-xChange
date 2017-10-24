Rails.application.routes.draw do
  get 'demands/create'

  get 'demands/destroy'

  get 'demands/show'

  get 'notifications/link_through'

  get 'book_feed/show'

  get 'password_resets/new'

  get 'password_resets/edit'

  get '/conversations' => 'conversations#index'

  root 'static_pages#home'
  get    '/about'   => 'static_pages#about'
  get    '/contact' => 'static_pages#contact'
  get    '/signup'  => 'users#new'
  post   '/signup'  => 'users#create'
  get    '/login'   => 'sessions#new'
  post   '/login'   => 'sessions#create'
  delete '/logout'  => 'sessions#destroy'
  get    '/books'   => 'books#show'
  get    '/demands' => 'demands#show'
  get    '/prompt'  => 'users#prompt'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :books,               only: [:create, :destroy, :edit, :update]
  resources :conversations,       only: [:index, :create, :destroy]
  resources :demands,             only: [:create, :show, :destroy]
  resources :conversations do
    resources :messages, only: [:index, :create, :destroy]
  end
  resources :books do
    collection do
      get :trade
    end
  end
end
