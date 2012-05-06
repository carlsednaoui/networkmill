class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_current_user
    unless current_user
      flash[:error] = "You must be logged in"
      redirect_to "/"
    end
  end

  def user_is_current_user
    unless current_user == User.find(session[:user_id])
      flash[:error] = "You do not have access to this data."
      redirect_to "/"
    end
  end
end
