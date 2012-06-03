class ApplicationController < ActionController::Base
  protect_from_forgery

  # Devise: Where to redirect users once they have logged in
  def after_sign_in_path_for(resource)
    if request.subdomain.present?
    	mobile_preferences_path
    else
    	dashboard_path
  	end
  end
end
