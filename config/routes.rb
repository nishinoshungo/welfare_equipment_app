Rails.application.routes.draw do
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show]
    resources :categories, only: [:index, :create, :edit, :update, :destroy]
    resources :return_items, only: [:index, :update]
    get '/', to: "homes#top"
    get '/menu', to: "homes#menu"
  end
  devise_for :admin, controllers: {
    sessions: 'devise_admins/sessions',
    passwords: 'devise_admins/passwords',
    registrations: 'devise_admins/registrations',
  }
  devise_for :customers, skip: 'registrations', controllers: {
    sessions: 'devise_customers/sessions',
    passwords: 'devise_customers/passwords',
    registrations: 'devise_customers/registrations',
  }

  devise_scope :customer do
    get '/customers/sign_up',
    to: 'devise_customers/registrations#new', as: :new_customer_registration
    post 'customers', to: 'devise_customers/registrations#create'
  end

  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about'

  get '/customers/my_page', to: 'public/customers#show'
  get '/customers/edit', to: 'public/customers#edit'
  patch '/customers', to: 'public/customers#update'
  get '/customers/unsubscribe', to: 'public/customers#unsubscribe'
  patch '/customers/withdraw', to: 'public/customers#withdraw'

  get '/items', to: 'public/items#index'
  get '/search', to: 'public/items#search'
  get '/items/:id', to: 'public/items#show'
  get '/recommend', to: 'public/items#recommend'

  get '/customers/favorite_items', to: 'public/favorite_items#index'
  post '/customers/favorite_items', to: 'public/favorite_items#create', as: :create_favorite_items
  delete '/customers/favorite_items/:id',
  to: 'public/favorite_items#destroy', as: :destroy_favorite_items

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
  patch '/orders/order_items/:id', to: 'public/orders#update', as: :update_rental_status

  get '/items/reviews/new', to: 'public/reviews#new'
  post '/items/reviews', to: 'public/reviews#create'
  get '/items/reviews/:id/edit', to: 'public/reviews#edit'
  patch '/items/reviews/:id', to: 'public/reviews#update'
  delete '/items/reviews/:id', to: 'public/reviews#destroy', as: :destroy_review

  get '/contacts/new', to: 'public/contacts#new', as: :contact_new
  post '/contacts/confirm', to: 'public/contacts#confirm', as: :contact_confirm
  post '/contacts/back', to: 'public/contacts#back', as: :contact_back
  post '/contacts', to: 'public/contacts#create', as: :contact_create
  get '/contacts/complete', to: 'public/contacts#complete', as: :contact_complete
end
