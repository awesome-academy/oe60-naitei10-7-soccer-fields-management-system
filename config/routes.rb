Rails.application.routes.draw do
  # Home path
  root "static_pages#home"

  # Auth path
  scope :auth do
    get "signup", to: "registrations#new"
    post "signup", to: "registrations#create"
    get "signin", to: "sessions#new"
    post "signin", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
  end

  # Change language path
  get "switch_language/:locale", to: "application#switch_language", as: "switch_language"

  # Active account registration
  get "activate/:activation_digest", to: "accounts#activations", as: "activate_user", constraints: { activation_digest: /.*/ }

  # Field path
  resources :fields, only: %i(show index)

  # Field type path
  resources :field_types, only: %i(show create)

  # User path
  resources :users

  namespace :admin do
    resources :users
    resources :fields
    resources :static_pages do
      member do
        patch "cancel"
      end
    end
  end

  # Booking history path
  resources :bookings, only: %i(index destroy create)

  # Favorite path
  resources :favorite_field_types, only: :create

  # Review field type path
  resources :reviews, only: %i(update create)

  # Comments path
  resources :comments, only: :create
end
