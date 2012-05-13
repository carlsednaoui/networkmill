class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :dashboard
  def index
    redirect_to dashboard_path if current_user
  end

  def dashboard
    @user = current_user
    @contacts = Contact.find_all_by_user_id(current_user)
  end
  
end
