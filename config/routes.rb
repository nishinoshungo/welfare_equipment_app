Rails.application.routes.draw do
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
end
