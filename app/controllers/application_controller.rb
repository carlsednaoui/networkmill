class ApplicationController < ActionController::Base
  protect_from_forgery

  # Devise: Redirect users once they have logged in
  def after_sign_in_path_for(resource)
    if request.subdomain.present?
      add_mobile_contact_path
    else
    	dashboard_path
  	end
  end

  # ===============================================
  # == Commented this out to make rspec tests work
  # ===============================================
  # Override Devise create session controller
  # Devise::SessionsController.class_eval do
	# 	def create
	# 	 resource = warden.authenticate!(auth_options)
	#     set_flash_message(:notice, :signed_in) if is_navigational_format?
	#     sign_in(resource_name, resource)
	#     @sign_in_path = after_sign_in_path_for(resource)
	# 	end
	# end
  
end
