Rails.application.routes.draw do
  get 'welcome/index'
  root "welcome#index"
  resources :petitions
  resources :verified_codes
end
