Networkmill::Application.routes.draw do
  root :to => "home#index"

  devise_for :users
  resources :contacts
  resources :users, :only => [:new, :create, :update]

  get '/edit_profile' => 'users#edit', :as => 'edit_user' # overriding resources
  get "/dashboard" => "home#dashboard", :as => 'dashboard'
end