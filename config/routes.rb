Networkmill::Application.routes.draw do
  root :to => "home#index"

  devise_for :users
  resources :contacts
  resources :users, :only => [:new, :create, :update]

  # overriding devise edit profil path
	devise_scope :user do
  	get "/edit_profile" => "devise/registrations#edit", :as => 'edit_user'
	end

  get "/dashboard" => "home#dashboard", :as => 'dashboard'
end