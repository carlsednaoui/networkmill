class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :dashboard
  
  def index
    redirect_to dashboard_path if current_user
  end

  # Use Twilio to send user the app URL
  def send_text
    @client = Twilio::REST::Client.new TWILIO_SID, TWILIO_AUTH
    @client.account.sms.messages.create(
      :from => '+14155992671',
      :to => "+#{number}",
      :body => "Woo, it works! Go to www.awesome.com"
    )
    redirect_to root_url
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