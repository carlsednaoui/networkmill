class SessionsController < ApplicationController
  def new
  end

  def create
    auth = request.env["omniauth.auth"]

    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    user.contact_intensity = 3
    if user.save!
      session[:user_id] = user.id
      redirect_to dashboard_url, :notice => "Signed in!"
    else
      redirect_to root_url, :error => "Could not create account"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  def failure
    redirect_to root_url, :alert => "Authentication failed, please try again."
  end
end
