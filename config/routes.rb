Networkmill::Application.routes.draw do

  ##################
  # Mobile Routes
  ##################
 
  # Enable mobile subdomain
  # To access it use http://lvh.me:3000
  match '', :to => 'mobile#index', :constraints => lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  
  # Note: In mobile mode we are using /settings as the preference URL,
  # to avoid conflicting with /preferences from desktop mode.
  get "/settings" => "mobile#preferences", :as => 'mobile_preferences'
  get "/networking" => "mobile#add_contact", :as => 'add_mobile_contact'


  ##################
  # Desktop Routes
  ##################

  root :to => "home#index"
  
  resources :contacts
  resources :users, :only => [:new, :update]

  get "/dashboard" => "home#dashboard", :as => 'dashboard'
  get "/preferences" => "users#edit", :as => 'preferences'
  get "/check_email/:email" => "users#check_email", :as => 'check_email', :constraints => { :email => /[^\/]+/ }

  # Overriding devise after_sign_up_path to take you to the registration controller
  devise_for :users, :controllers => { :registrations => "registrations" }

 	# Overriding devise root_url
	devise_for :users do
	 get 'users', :to => 'home#dashboard', :as => :user_root
  end

end