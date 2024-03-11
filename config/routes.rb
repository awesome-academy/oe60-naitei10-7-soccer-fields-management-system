Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'password_resets/create'
  get 'password_resets/update'
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

  resources :users

  resources :password_resets, only: %i(new create edit update)

end
