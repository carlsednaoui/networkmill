Networkmill::Application.routes.draw do
  root :to => "users#index"

  resources :users
  resources :contacts
  resources :identities

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
end
