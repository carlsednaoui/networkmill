Networkmill::Application.routes.draw do
  
  # Enable Mobile subdomain
  match '', to: 'mobile#index', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  
  get "/mobile" => "mobile#preferences", :as => 'mobile'



  root :to => "home#index"
  
  resources :contacts
  resources :users, :only => [:new, :update]

  get "/dashboard" => "home#dashboard", :as => 'dashboard'
  get "/preferences" => "users#edit", :as => 'preferences'

  # Overriding devise after_sign_up_path
  devise_for :users, :controllers => { :registrations => "registrations" }

 	# Overriding devise root_url
	devise_for :users do
	 get 'users', :to => 'home#dashboard', :as => :user_root
  end
end