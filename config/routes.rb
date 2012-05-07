Networkmill::Application.routes.draw do
  root :to => "home#index"

  match "/dashboard" => "home#dashboard"

  resources :contacts
  devise_for :users

  resources :users, :only => [:new, :create, :update]
  #Allow users to edit their profiles - overriding resources
  get '/edit_profile' => 'users#edit', :as => 'edit_user'
end
