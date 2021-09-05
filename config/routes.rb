Rails.application.routes.draw do

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end
  devise_for :admin, controllers: {
    sessions: 'devise_admins/sessions',
    passwords: 'devise_admins/passwords',
    registrations: 'devise_admins/registrations'
  }
  devise_for :customers, skip: 'registrations', controllers: {
    sessions: 'devise_customers/sessions',
    passwords: 'devise_customers/passwords',
    registrations: 'devise_customers/registrations'
  }

  devise_scope :customer do
    get '/customers/sign_up', to: 'devise_customers/registrations#new', as: :new_customer_registration
    post 'customers', to: 'devise_customers/registrations#create'
  end

  root to: 'public/homes#top'
  get '/about' ,to: 'public/homes#about'

  get '/customers/my_page', to: 'public/customers#show'
  get '/customers/edit', to: 'public/customers#edit'
  patch '/customers', to: 'public/customers#update'
  get '/customers/unsubscribe', to: 'public/customers#unsubscribe'
  patch '/customers/withdraw', to: 'public/customers#withdraw'

  get '/items', to: 'public/items#index'
  get '/items/:id', to: 'public/items#show'

  get '/cart_items', to: 'public/cart_items#index'
  patch '/cart_items/:id', to: 'public/cart_items#update'
  delete '/cart_items/:id', to: 'public/cart_items#destroy'
  delete '/cart_items', to: 'public/cart_items#destroy_all'
  post '/cart_items', to: 'public/cart_items#create'

  get '/orders/confirm', to: 'public/orders#confirm'
  get '/orders/complete', to: 'public/orders#complete'
  get '/orders', to: 'public/orders#index'
  get '/orders/:id', to: 'public/orders#show'
  post '/orders', to: 'public/orders#create'

end