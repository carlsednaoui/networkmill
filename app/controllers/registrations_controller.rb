# This controller is used to redirect a user to the edit_profile when they sign up for the 1st time.
# This overrides the Devise defaults (which would reditect to root URL)

class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
  	preferences_path
  end
end