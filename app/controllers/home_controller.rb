class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:dashboard, :welcome]
  before_filter :beta_invite_auth_admin, :only => [:beta_invite_dashboard, :create_beta_invite]
  
  def index
    redirect_to dashboard_path if current_user
  end  

  def welcome
    redirect_to dashboard_path if !current_user.first_time
  end

  def dashboard
    redirect_to welcome_path if current_user.first_time
    @user = current_user
    
    @contacts = Contact.find_all_by_user_id(current_user.id).reverse
    @contact = Contact.new

    @categories = current_user.categories
    @category = Category.new
  end

  # =================================
  # First time (tutorial mode)
  # =================================

  # Turn first_time off from welcome screen
  def first_time_off
    current_user.update_attributes(:first_time => false)
    redirect_to dashboard_path if !current_user.first_time
  end

  # Turn first_time on from preference menu
  def first_time_on
    current_user.update_attributes(:first_time => true)
    redirect_to welcome_path if current_user.first_time
  end

  # =================================
  # Twilio
  # =================================

  def send_text
    number = params[:number]

    @client = Twilio::REST::Client.new TWILIO_SID, TWILIO_AUTH
    @client.account.sms.messages.create(
      :from => '+16464806552', # This is our Twilio number
      :to => "#{number}",
      :body => "Hey there good looking, go to m.networkmill.com to network like a boss."
    )
    if current_user
      current_user.update_attributes(:tel_number => number)
      redirect_to dashboard_path, :notice => "Schweet, check your phone..."
    else
      redirect_to root_url, :notice => "Schweet, check your phone..."
    end
  end

  # =================================
  # Contact categories
  # =================================

  def create_category
    @category = Category.new(params[:category])
    @category.user = current_user
    if @category.save
      redirect_to dashboard_path, notice: "new contact category created" 
    else
      redirect_to dashboard_path, notice: "ohh no, a blank category - no bueno"
    end
  end

  # =================================
  # Feedback
  # =================================

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

  # =================================
  # Beta invites
  # =================================

  def beta_invite_dashboard
    @new_beta = BetaInvite.new
    @emails_already_in_beta = BetaInvite.all.reverse
  end

  def create_beta_invite
    @new_beta = BetaInvite.new(params[:beta_invite])
    redirect_to beta_invites_path if @new_beta.save
  end

  protected

  # Basic HTML Authentication for beta invistations
  def beta_invite_auth_admin
    authenticate_or_request_with_http_basic do |username, password|
      username == "ilove" && password == "tits"
    end
  end
  
end