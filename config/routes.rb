Networkmill::Application.routes.draw do
  root :to => "home#index"
  
  resources :contacts
  resources :users, :only => [:new, :update]

  get "/dashboard" => "home#dashboard", :as => 'dashboard'

  # Overriding devise after_sign_up_path
  devise_for :users, :controllers => { :registrations => "registrations" }
  
  # Overriding devise edit profile path
  devise_scope :user do
    get "/edit_profile" => "devise/registrations#edit", :as => 'edit_user'
  end

 	# Overriding devise root_url
	devise_for :users do
	 get 'users', :to => 'home#dashboard', :as => :user_root
	end
end
