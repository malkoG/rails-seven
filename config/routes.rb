Rails.application.routes.draw do
  devise_for :admin_users
  root "petitions#index"
  resources :petitions
  resources :verified_codes

  admin_custom_option = { sessions: 'staffs/sessions' }
  admin_options = { controllers: admin_custom_option, as: 'staff' }
  admin_options[:path] = 'staffs'
  scope :staffs do
    extend StaffsRoutes
  end
  devise_for :admin_users, admin_options
end
