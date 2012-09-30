# Redirect a user to the edit_profile when they sign up.
# This overrides the Devise defaults (which would reditect to root URL)

class RegistrationsController < Devise::RegistrationsController
  protected

  # The below code is technically not needed as users are directly redirected to
  # the welcome path if first_time == true (we are automatically adding
  # firt_time == true from the db migration). However, the below code saves one
  # 302 redirect and avoids going from dashboard_path to welcome_path.
  def after_sign_up_path_for(resource)
    welcome_path
  end
end