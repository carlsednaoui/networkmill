class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :dashboard
  
  def index
    redirect_to dashboard_path if current_user
  end

  # Use Twilio to send mobile app URL
  def send_text
    number = params[:number]

    @client = Twilio::REST::Client.new TWILIO_SID, TWILIO_AUTH
    @client.account.sms.messages.create(
      :from => '+16464806552',
      :to => "#{number}",
      :body => "Hey there good looking, go to m.networkmill.com to network like a boss."
    )
    if current_user
      redirect_to dashboard_path, :notice => "Schweet, check your phone..."
    else
      redirect_to root_url, :notice => "Schweet, check your phone..."
    end
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