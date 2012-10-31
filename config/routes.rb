Networkmill::Application.routes.draw do

  #============================
  # Mobile Routes
  #============================
 
  # Enable mobile subdomain
  # To access it use http://m.lvh.me:3000 or http://m.networkmill.dev
  match '', :to => 'mobile#index', :constraints => lambda { |r| r.subdomain.present? && r.subdomain != 'www' }

  get "/networking" => "mobile#add_contact", :as => 'add_mobile_contact'
  post "/mobile-create-contact" => "mobile#create_contact", :as => 'mobile_create_contact'
  post "/update-mobile-user" => "mobile#update_mobile_user", :as => 'update_mobile_user'
  get "/forgot-password" => "mobile#forgot_password", :as =>'forgot_password'

  get "/m-feedback" => "mobile#feedback", :as => 'mobile_feedback'
  post "/m-feedback" => "mobile#post_feedback", :as => 'post_mobile_feedback'


  #============================
  # Desktop Routes
  #============================

  root :to => "home#index"

  resources :contacts
  resources :users, :only => [:new, :update]

  # first_time aka: onboarding/ tutorial
  get "welcome" => "home#welcome", :as => 'welcome'
  post "first-time-off" => "home#first_time_off", :as => 'first_time_off'
  post "first-time-on" => "home#first_time_on", :as => 'first_time_on'

  get "/dashboard" => "home#dashboard", :as => 'dashboard'
  post "/new-category" => "home#create_category", :as => 'new_category'
  
  # the trick
  get "/preferences" => "users#edit", :as => 'preferences'
  put "/preferences" => "users#update", :as => 'update_preferences'
  # end
  
  get "/check_email/:email" => "users#check_email", :as => 'check_email', :constraints => { :email => /[^\/]+/ }
  
  get "/export-contacts" => "users#export_contacts", :as => 'export_contacts'
  post "/import-contacts" => "users#import_contacts", :as => 'import_contacts'

  post "/send_test_email" => "users#send_test_email", :as => 'send_test_email'
  get "/privacy-policy" => "home#privacy_policy", :as => 'privacy_policy'
  get "/tos" => "home#tos", :as => 'tos'
  get "/faq" => "home#faq", :as => 'faq'

  get "/feedback" => "home#feedback", :as => 'feedback'
  post "/feedback" => "home#post_feedback", :as => 'post_feedback'

  # Allow user to text himself the app url
  post "/send-text" => "home#send_text", :as => 'send_text'

  #============================
  # Devise overrides
  #============================
  # Overriding devise after_sign_up_path to take you to the registration controller
  devise_for :users, :controllers => { :registrations => "registrations" }

  # Overriding devise root_url
  devise_scope :users do
    get 'users', :to => 'home#dashboard', :as => :user_root
  end

  #============================
  # Add beta codes
  #============================

  get "/invite" => "home#beta_invite_dashboard", :as => "beta_invites"
  post "/invite" => "home#create_beta_invite", :as => "create_beta_invite"

end