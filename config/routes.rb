Networkmill::Application.routes.draw do
  root :to => "home#index"

  match "/dashboard" => "home#dashboard"

  resources :identities
#  resources :users
  resources :contacts

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/failure" => "sessions#failure"
end
