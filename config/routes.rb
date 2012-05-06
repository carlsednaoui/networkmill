Networkmill::Application.routes.draw do
  root :to => "home#index"

  match "/dashboard" => "home#dashboard"

  resources :identities
  resources :contacts

  resources :users, :only => [:create, :show, :update]
  #Allow users to edit their profiles - overriding resources
  get '/edit_profile' => 'users#edit', :as => 'edit_user'

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/failure" => "sessions#failure"
end
