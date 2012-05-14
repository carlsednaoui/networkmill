Networkmill::Application.routes.draw do
  root :to => "home#index"
  
  resources :contacts
  resources :users, :only => [:new, :update]

  get "/dashboard" => "home#dashboard", :as => 'dashboard'
  get "/preferences" => "users#edit", :as => 'preferences'

  # Overriding devise after_sign_up_path
  devise_for :users, :controllers => { :registrations => "registrations" }
  
  # Deprecated - Overriding devise edit profile path
   devise_scope :user do
     get "/advanced" => "devise/registrations#edit", :as => 'advanced_changes'
   end

 	# Overriding devise root_url
	devise_for :users do
	 get 'users', :to => 'home#dashboard', :as => :user_root
	end
end
