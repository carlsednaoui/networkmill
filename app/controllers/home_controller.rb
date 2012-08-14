class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :dashboard
  
  def index
    redirect_to dashboard_path if current_user
  end

  def dashboard
    @user = current_user
    @contacts = Contact.find_all_by_user_id(current_user.id).reverse
    @contact = Contact.new
  end

  def feedback
    @feedback = Feedback.new
  end

  def post_feedback
    @feedback = Feedback.new
    @feedback.user_id = current_user.id if current_user.present?
    @feedback.message = params[:feedback][:message]
    @feedback.save!
    UserMailer.delay.send_feedback_to_team(@feedback)
    redirect_to root_url
  end
  
end