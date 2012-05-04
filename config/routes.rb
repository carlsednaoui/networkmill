Networkmill::Application.routes.draw do
  root :to => "users#index"

  resources :identities
  resources :users
  resources :contacts

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/failure" => "sessions#failure"
end
