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
  devise_for :customers, controllers: {
    sessions: 'devise_customers/sessions',
    passwords: 'devise_customers/passwords',
    registrations: 'devise_customers/registrations'
  }

  root to: 'public/homes#top'
  get '/about' ,to: 'public/homes#about'
end